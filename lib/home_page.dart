import 'package:flutter/material.dart';
import 'package:my_contact/edit_contact.dart';

import 'contact.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController snameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController webController = TextEditingController();
  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    MaterialApp(
        debugShowCheckedModeBanner: false,);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            CircleAvatar(
              backgroundColor: Colors.blue[400],
              radius: 23,
              child: Text(
                'Contacts',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ), //Text
            ), //Circl
            SizedBox(
              width: 2,
              height: 2,),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Contact Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: snameController,
              keyboardType: TextInputType.text,
              maxLength: 10,

              decoration: const InputDecoration(
                  hintText: 'Second Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ))),
            ),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                  hintText: 'Contact Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ))),
            ),
            TextField(
              controller: companyController,
              keyboardType: TextInputType.text,
              maxLength: 10,

              decoration: const InputDecoration(
                  hintText: 'Comany Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ))),
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              maxLength: 10,

              decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ))),
            ),
            TextField(
              controller: webController,
              keyboardType: TextInputType.url,
              maxLength: 10,

              decoration: const InputDecoration(
                  hintText: 'Web Link',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ))),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 130,
                  height: 40,
                  child: ElevatedButton(
                    child: const Text('Save Contact'),
                    onPressed: () {
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();
                      String sname = snameController.text.trim();
                      String company = companyController.text.trim();
                      String email = emailController.text.trim();
                      String web = webController.text.trim();
                      if (name.isNotEmpty && contact.isNotEmpty && sname.isNotEmpty && company.isNotEmpty && email.isNotEmpty && web.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          contactController.text = '';
                          snameController.text = '';
                          companyController.text = '';
                          emailController.text = '';
                         webController.text = '';
                          contacts.add(Contact(name: name, contact: contact, sname: sname, company: company, email: email, web: web));
                          //   Navigator.of(context).pop();

                        });
                      }              },
                  ),
                ),
                SizedBox(
                  width: 10,
                  height: 10,),
                SizedBox(
                  width: 130,
                  height: 40,
                  child: ElevatedButton(

                      onPressed: () {
                        //
                        String name = nameController.text.trim();
                        String contact = contactController.text.trim();
                        if (name.isNotEmpty && contact.isNotEmpty) {
                          setState(() {
                            nameController.text = '';
                            contactController.text = '';
                            contacts[selectedIndex].name = name;
                            contacts[selectedIndex].contact = contact;
                            selectedIndex = -1;
                          });
                        }
                        //
                      },
                      child: const Text('Update Contact')),
                ),
              ],
            ),
            const SizedBox(height: 10),
            contacts.isEmpty
                ? const Text(
              'No Contact yet..',
              style: TextStyle(fontSize: 22),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) => getRow(index),
              ),
            )
          ],
        ),

      ),
  );

  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          index % 2 == 0 ? Colors.deepPurpleAccent : Colors.blue,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contact),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    nameController.text = contacts[index].name;
                    contactController.text = contacts[index].contact;
                    setState(() {
                      selectedIndex = index;
                      // Navigator.push(
                      // context,
                      //                MaterialPageRoute(
                      //                builder: (context) =>  EditContact(contacts[index].name,contacts[index].contact),
                      // // Pass the arguments as part of the RouteSettings. The
                      // // DetailScreen reads the arguments from these settings.
                      //                 settings: RouteSettings(
                      //                 arguments: contacts[index],
                      //                     ),
                      //                     ),
                    });
                        },
                                        //
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      contacts.removeAt(index);
                    });
                    //
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }


}
