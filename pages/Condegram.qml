import QtQuick 2.0


Rectangle
{
    id:root

    anchors.topMargin: 20
    width: 200
    height: 200
    color: "transparent"

    Image {
        id: person
        source: 'qrc:/images/Stairs_F.svg'
        sourceSize.width: parent.width/2
        sourceSize.height: parent.height/2
        scale: 0.8
        anchors.centerIn: parent
    }

    property double value: 2
    onValueChanged: canvas.requestPaint()
    Behavior on value {
        NumberAnimation{
            easing.type: Easing.OutElastic
            duration: 100
        }
    }


    NumberAnimation { id: theAnim; target: root; property: "value"; from: 0; to: 40 }

    MouseArea {
        anchors.fill: parent
        onClicked: theAnim.start()
    }

    Canvas
    {
        id: canvas
        anchors.fill: parent
        //antialiasing: true

        onPaint:
        {
            var offset = 40
            var bars_count = 100
            var ctx = getContext("2d");
            ctx.lineWidth = 3;
            ctx.strokeStyle = Qt.rgba(0.3, 0.7, 1, 1.0);
            ctx.globalAlpha = 1.0;
            ctx.beginPath();
            ctx.arc(width/2, height/2, height/2-offset, 0, 2*Math.PI);
            ctx.stroke();
            ctx.restore();

            ctx.clearRect(0, 0, canvas.width, canvas.height);

            for(var i =0;i<bars_count;i++)
            {
                ctx.strokeStyle = Qt.rgba(Math.random(), 0.7, 1, 1.0);
                ctx.save();
                ctx.translate(width/2,height/2);
                ctx.rotate(((i)*360/bars_count)*Math.PI/180);
                ctx.beginPath();

                ctx.moveTo(0,-(height/2-1)+value*Math.random());
                ctx.lineTo(0,-(height/2-1)+offset);

                ctx.stroke();
                ctx.restore();
            }
        }
    }
}

