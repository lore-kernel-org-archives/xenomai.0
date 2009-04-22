MIME-Version: 1.0
Date: Wed, 22 Apr 2009 10:27:48 +0200
Message-ID: <37f89760904220127t63317a8cr4a4295c0a726f1c2@domain.hid>
From: Marcel Soulot <msoulot@domain.hid>
Content-Type: multipart/alternative; boundary=001636c92545e493fa04682089cf
Subject: [Xenomai-help] Manage PCI irq to avoid conflict
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--001636c92545e493fa04682089cf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I'm looking for a way to allocate a specific IRQ to a PCI card.
I have two PCI cards and I can't change their slot and I try to change the
bios configuration but no success.

My first PCI card uses two IRQs 10 and 12 and my second uses one IRQs 5.
These IRQs are also use by the usb controller.
One way that I found is to disabled usb controller but I need it so I can't
use this solution.

Here is my IRQ allocation :
           CPU0
  0:         84    XT-PIC-XT        timer
  1:        531    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  3:         92    XT-PIC-XT        serial
  4:          4    XT-PIC-XT
  5:          0    XT-PIC-XT        uhci_hcd:usb3
  7:        315    XT-PIC-XT        ehci_hcd:usb1
  8:          2    XT-PIC-XT        rtc0
  9:          0    XT-PIC-XT        uhci_hcd:usb4
 10:          0    XT-PIC-XT        uhci_hcd:usb2
 11:      22240    XT-PIC-XT        eth0
 12:          0    XT-PIC-XT        Intel 82801DB-ICH4
 14:       1981    XT-PIC-XT        ide0
 15:          0    XT-PIC-XT        ide1
NMI:          0   Non-maskable interrupts
LOC:     167780   Local timer interrupts
RES:          0   Rescheduling interrupts
CAL:          0   function call interrupts
TLB:          0   TLB shootdowns
TRM:          0   Thermal event interrupts
SPU:          0   Spurious interrupts
ERR:          0
MIS:          0

Thanks for your help,
Marcel.

--001636c92545e493fa04682089cf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SGksPGJyPjxicj5JJiMzOTttIGxvb2tpbmcgZm9yIGEgd2F5IHRvIGFsbG9jYXRlIGEgc3BlY2lm
aWMgSVJRIHRvIGEgUENJIGNhcmQuPGJyPkkgaGF2ZSB0d28gUENJIGNhcmRzIGFuZCBJIGNhbiYj
Mzk7dCBjaGFuZ2UgdGhlaXIgc2xvdCBhbmQgSSB0cnkgdG8gY2hhbmdlIHRoZSBiaW9zIGNvbmZp
Z3VyYXRpb24gYnV0IG5vIHN1Y2Nlc3MuPGJyPjxicj5NeSBmaXJzdCBQQ0kgY2FyZCB1c2VzIHR3
byBJUlFzIDEwIGFuZCAxMiBhbmQgbXkgc2Vjb25kIHVzZXMgb25lIElSUXMgNS48YnI+ClRoZXNl
IElSUXMgYXJlIGFsc28gdXNlIGJ5IHRoZSB1c2IgY29udHJvbGxlci48YnI+T25lIHdheSB0aGF0
IEkgZm91bmQgaXMgdG8gZGlzYWJsZWQgdXNiIGNvbnRyb2xsZXIgYnV0IEkgbmVlZCBpdCBzbyBJ
IGNhbiYjMzk7dCB1c2UgdGhpcyBzb2x1dGlvbi4gPGJyPjxicj5IZXJlIGlzIG15IElSUSBhbGxv
Y2F0aW9uIDo8YnI+oKCgoKCgoKCgoCBDUFUwoKCgoKCgIDxicj6gIDA6oKCgoKCgoKAgODSgoKAg
WFQtUElDLVhUoKCgoKCgoCB0aW1lcjxicj4KoCAxOqCgoKCgoKAgNTMxoKCgIFhULVBJQy1YVKCg
oKCgoKAgaTgwNDI8YnI+oCAyOqCgoKCgoKCgoCAwoKCgIFhULVBJQy1YVKCgoKCgoKAgY2FzY2Fk
ZTxicj6gIDM6oKCgoKCgoKAgOTKgoKAgWFQtUElDLVhUoKCgoKCgoCBzZXJpYWw8YnI+oCA0OqCg
oKCgoKCgoCA0oKCgIFhULVBJQy1YVKCgoKCgIDxicj6gIDU6oKCgoKCgoKCgIDCgoKAgWFQtUElD
LVhUoKCgoKCgoCB1aGNpX2hjZDp1c2IzPGJyPgqgIDc6oKCgoKCgoCAzMTWgoKAgWFQtUElDLVhU
oKCgoKCgoCBlaGNpX2hjZDp1c2IxPGJyPqAgODqgoKCgoKCgoKAgMqCgoCBYVC1QSUMtWFSgoKCg
oKCgIHJ0YzA8YnI+oCA5OqCgoKCgoKCgoCAwoKCgIFhULVBJQy1YVKCgoKCgoKAgdWhjaV9oY2Q6
dXNiNDxicj6gMTA6oKCgoKCgoKCgIDCgoKAgWFQtUElDLVhUoKCgoKCgoCB1aGNpX2hjZDp1c2Iy
PGJyPqAxMTqgoKCgoCAyMjI0MKCgoCBYVC1QSUMtWFSgoKCgoKCgIGV0aDA8YnI+CqAxMjqgoKCg
oKCgoKAgMKCgoCBYVC1QSUMtWFSgoKCgoKCgIEludGVsIDgyODAxREItSUNINDxicj6gMTQ6oKCg
oKCgIDE5ODGgoKAgWFQtUElDLVhUoKCgoKCgoCBpZGUwPGJyPqAxNTqgoKCgoKCgoKAgMKCgoCBY
VC1QSUMtWFSgoKCgoKCgIGlkZTE8YnI+Tk1JOqCgoKCgoKCgoCAwoKAgTm9uLW1hc2thYmxlIGlu
dGVycnVwdHM8YnI+TE9DOqCgoKAgMTY3NzgwoKAgTG9jYWwgdGltZXIgaW50ZXJydXB0czxicj4K
UkVTOqCgoKCgoKCgoCAwoKAgUmVzY2hlZHVsaW5nIGludGVycnVwdHM8YnI+Q0FMOqCgoKCgoKCg
oCAwoKAgZnVuY3Rpb24gY2FsbCBpbnRlcnJ1cHRzPGJyPlRMQjqgoKCgoKCgoKAgMKCgIFRMQiBz
aG9vdGRvd25zPGJyPlRSTTqgoKCgoKCgoKAgMKCgIFRoZXJtYWwgZXZlbnQgaW50ZXJydXB0czxi
cj5TUFU6oKCgoKCgoKCgIDCgoCBTcHVyaW91cyBpbnRlcnJ1cHRzPGJyPkVSUjqgoKCgoKCgoKAg
MDxicj4KTUlTOqCgoKCgoKCgoCAwPGJyPjxicj5UaGFua3MgZm9yIHlvdXIgaGVscCw8YnI+TWFy
Y2VsLjxicj4K
--001636c92545e493fa04682089cf--

