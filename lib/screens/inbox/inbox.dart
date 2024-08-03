import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:just_complaint/provider/response_provider.dart';
import 'package:just_complaint/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ResponseScreen extends StatefulWidget {
  @override
  _ResponseScreenState createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  void _fetchData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final responseProvider = Provider.of<ResponseProvider>(context, listen: false);
    final userId = userProvider.user?.id ?? '';

    await responseProvider.fetchResponses(userId);
  }

  @override
  Widget build(BuildContext context) {
    final responseProvider = Provider.of<ResponseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Responses From Stakeholders'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
        ),
      ),
      body: responseProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : responseProvider.error.isNotEmpty
              ? Center(child: Text(responseProvider.error))
              : responseProvider.responses.isEmpty
                  ? Center(child: Text('No Student Inbox found.'))
                  : ListView.builder(
                      itemCount: responseProvider.responses.length,
                      itemBuilder: (context, index) {
                        final response = responseProvider.responses[index];
                        final now = DateTime.now();
                        final respondedAt = response.respondedAt;
                        String subtitleText;

                        if (respondedAt.isAfter(now.subtract(Duration(minutes: 1)))) {
                          subtitleText = 'Just now';
                        } else if (respondedAt.isAfter(now.subtract(Duration(hours: 1)))) {
                          subtitleText = '${now.difference(respondedAt).inMinutes} minutes ago';
                        } else if (respondedAt.isAfter(now.subtract(Duration(days: 1)))) {
                          subtitleText = DateFormat('hh:mm a').format(respondedAt);
                        } else if (respondedAt.isAfter(now.subtract(Duration(days: 2)))) {
                          subtitleText = 'Yesterday at ${DateFormat('hh:mm a').format(respondedAt)}';
                        } else {
                          subtitleText = DateFormat('dd/MM/yyyy hh:mm a').format(respondedAt);
                        }

                        return Slidable(
                          key: ValueKey(response.id),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.25,
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  responseProvider.deleteResponse(response.id);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(response.text),
                            subtitle: Text(
                              '$subtitleText',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
