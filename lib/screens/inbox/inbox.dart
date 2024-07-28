import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:just_complaint/provider/response_provider.dart';
import 'package:just_complaint/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ResponseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responseProvider = Provider.of<ResponseProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.user?.id ?? '';

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
                        return ListTile(
                          title: Text(response.text),
                          subtitle: Text('Responded At: ${response.respondedAt ?? 'Unknown'}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              responseProvider.deleteResponse(response.id);
                            },
                          ),
                        );
                      },
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          responseProvider.fetchResponses(userId);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
