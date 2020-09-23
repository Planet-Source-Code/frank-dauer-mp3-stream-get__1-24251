VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form Form1 
   BorderStyle     =   1  'Fest Einfach
   Caption         =   ".:mp3:::::get:."
   ClientHeight    =   1245
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5895
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   1245
   ScaleWidth      =   5895
   StartUpPosition =   2  'Bildschirmmitte
   Begin VB.PictureBox bild 
      AutoSize        =   -1  'True
      Height          =   810
      Left            =   4920
      Picture         =   "Form1.frx":20C2
      ScaleHeight     =   750
      ScaleWidth      =   750
      TabIndex        =   8
      Top             =   240
      Width           =   810
   End
   Begin VB.TextBox datei 
      Height          =   285
      Left            =   2280
      TabIndex        =   7
      Text            =   "doener.mp3"
      Top             =   840
      Width           =   2535
   End
   Begin VB.TextBox port 
      Height          =   285
      Left            =   2280
      TabIndex        =   5
      Text            =   "8000"
      Top             =   480
      Width           =   2535
   End
   Begin VB.TextBox server 
      Height          =   285
      Left            =   2280
      TabIndex        =   2
      Top             =   120
      Width           =   2535
   End
   Begin VB.CommandButton stopb 
      Enabled         =   0   'False
      Height          =   275
      Left            =   120
      Picture         =   "Form1.frx":3EB6
      Style           =   1  'Grafisch
      TabIndex        =   1
      Top             =   480
      Width           =   800
   End
   Begin VB.CommandButton musik 
      Height          =   275
      Left            =   120
      Picture         =   "Form1.frx":47A6
      Style           =   1  'Grafisch
      TabIndex        =   0
      Top             =   120
      Width           =   800
   End
   Begin MSWinsockLib.Winsock socke 
      Left            =   1800
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      RemoteHost      =   "213.86.48.250"
      RemotePort      =   8000
   End
   Begin VB.Label Label3 
      Caption         =   "Dateiname"
      Height          =   255
      Left            =   1200
      TabIndex        =   6
      Top             =   840
      Width           =   975
   End
   Begin VB.Label Label2 
      Caption         =   "Port"
      Height          =   255
      Left            =   1200
      TabIndex        =   4
      Top             =   480
      Width           =   615
   End
   Begin VB.Label Label1 
      Caption         =   "Server:"
      Height          =   255
      Left            =   1200
      TabIndex        =   3
      Top             =   120
      Width           =   615
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim data() As Byte



Public Sub musik_Click()
If server.Text <> "" And port.Text > 0 And port.Text < 65536 And datei.Text <> "" Then
musik.Enabled = False
server.Enabled = False
port.Enabled = False
datei.Enabled = False
stopb.Enabled = True
socke.RemoteHost = server.Text
socke.RemotePort = port.Text
socke.Connect
Open datei.Text For Binary Access Write As #1
End If
End Sub


Private Sub stopb_Click()
socke.Close
Close #1
stopb.Enabled = False
musik.Enabled = True
server.Enabled = True
port.Enabled = True
datei.Enabled = True
End Sub

Private Sub socke_Connect()
socke.SendData ("GET / HTTP/1.0" & vbCrLf & vbCrLf)
End Sub

Public Sub socke_DataArrival(ByVal bytesTotal As Long)
socke.GetData data(), vbByte
Put #1, , data()
End Sub

