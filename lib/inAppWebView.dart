import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

String viewID = "html-hello-Sign";

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => new _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: InAppWebView(
                    initialFile: "assets/jsonfromdart.html",
                    onWebViewCreated: (controller) async {
                      final data = <String, dynamic>{
                        "topic": "OPEN_SIGN_WIDGET",
                        "payload": {"url":
                        "https://app.hellosign.com/editor/embeddedSign?signature_id=90b516f3e43506320d6b32abfaab51c0&token=3cb2d718ad355ec7315313cd37cc0921"}
                      };

                      controller.addJavaScriptHandler(
                          handlerName: 'handlerFoo',
                          callback: (args) {
                            // return data to the JavaScript side!
                            return data;
                          });

                      // controller.addJavaScriptHandler(
                      //     handlerName: 'handlerFooWithArgs',
                      //     callback: (args) async {
                      //       print("STEP0 args -  ${args.first.toString()} - request Id");
                      //       if (data == "TEMPLATE_CREATED") {
                      //         print("TEMPLATE_CREATED");
                      //         print("-template created successfully");
                      //         // Navigator.pop(context);
                      //       }
                      //       if (args.first.toString() == "DOC_SIGNED") {
                      //         print("doc signed");
                      //       }
                      //       if (args.first.toString() == "WIDGET_CLOSED") {
                      //         Navigator.pop(context);
                      //         print("WIDGET_CLOSED");
                      //         print("STEP4 CLOSED");
                      //       }
                      //       return null;
                      //     });

                    },
                    onConsoleMessage: (controller, consoleMessage) async {

                      print("Message +++ ==== ---  ${consoleMessage.message}");

                      if (consoleMessage.message == "TEMPLATE_CREATED") {
                        print("TEMPLATE_CREATED");
                        print("-template created successfully");
                        // Navigator.pop(context);
                      }

                      if (consoleMessage.message == "DOC_SIGNED") {
                        print("STEP1 SIGNED");

                        // await _controller.saveSignedDocumentToApi(context,
                        //     taskId: taskId,
                        //     workFlowID: workflowId,
                        //     candidateId: candidateId,
                        //     questionName: taskTitle,
                        //     signedStatus: true,
                        //     linkId: linkid);
                      }
                      if (consoleMessage.message == "WIDGET_CLOSED") {
                        Navigator.pop(context);
                        // _controller.callBackSignedDoc(context);
                        print("STEP4 CLOSED");
                      }
                    },
                    onLoadStop: ((controller, url) async {}),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}