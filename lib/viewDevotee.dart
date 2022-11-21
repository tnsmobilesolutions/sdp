import 'package:flutter/material.dart';
import 'package:sdp/Models/vaktaModel.dart';

class ViewDevotee extends StatelessWidget {
  const ViewDevotee({Key? key, required this.item}) : super(key: key);
  final VaktaModel item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      width: 500,
      child: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(item.name.toString())
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sangha',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(item.sangha.toString())
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pali Date',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(item.paaliDate.toString())
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pranaami',
                  style: TextStyle(color: Colors.grey),
                ),
                Text('₹${item.pranaami}')
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sammilani No.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(item.sammilaniNo.toString())
                  ],
                ),
                // const Divider(
                //   thickness: 0.5,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Sammilani Year',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(item.sammilaniYear.toString())
                  ],
                ),
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Remark',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(item.remark.toString())
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Created By',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(item.createdBy.toString())
                  ],
                ),
                // const Divider(
                //   thickness: 0.5,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Created On',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(item.createdOn.toString())
                  ],
                ),
              ],
            ),
            const Divider(
              thickness: 0.5,
            ),
            if (item.updatedBy != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Updated By',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(item.updatedBy.toString())
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Updated On',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(item.updatedOn.toString())
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
