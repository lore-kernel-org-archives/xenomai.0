Message-ID: <431263.25323.qm@domain.hid>
Date: Tue, 5 May 2009 23:09:07 -0700 (PDT)
From: luan dinh <dinhluanbmt@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1587027275-1241590147=:25323"
Subject: [Xenomai-help] shared library in xenomai ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>


--0-1587027275-1241590147=:25323
Content-Type: multipart/alternative; boundary="0-782961513-1241590147=:25323"

--0-782961513-1241590147=:25323
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

hi.
My program included :
+ libsock.c
+ demo_use.c
+ Makefile
i build libsock.c as shared library named libmylibra.so ( support my_send()=
 function )
demo_use.c use my_send() and built with -lmylibra option
Thanks for any advise.
Luan Dinh
PS :i also attach the source code of these files=20
######### libsock. c###
void demo(void *agr)
{=A0=A0=A0=20
=A0=A0=A0 int len,i;
=A0=A0=A0 rt_task_set_periodic(NULL, TM_NOW, 100000000);
=A0=A0=A0 while (1) {=A0=A0=A0=A0=A0=A0=20
=A0=A0=A0 rt_task_wait_period(NULL);
=A0=A0=A0 len =3D send(sock, data, sizeof(data), 0);
=A0=A0=A0=A0=A0=A0=A0 if (len < 0)
=A0=A0=A0 {
=A0=A0=A0 =A0=A0=A0 printf("Sent Failed...!\n");
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
=A0=A0=A0 }=A0=A0=A0=20
=A0=A0=A0 }=A0=A0 =A0=A0=A0=20
}
/*my_send*/
int my_send()
{=A0=A0=A0=20
=A0=A0=A0 struct sched_param param;// =3D { .sched_priority =3D 1 };=A0=A0=
=A0 =A0
=A0=A0=A0 =A0 struct sockaddr_ll addr;
=A0=A0=A0 =A0 struct ifreq ifr;=A0=A0=A0=20
=A0=A0=A0 mlockall(MCL_CURRENT|MCL_FUTURE);=A0=A0=A0=20
=A0=A0=A0 if ((sock =3D socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL))) < 0)=
 {
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 perror("socket cannot be created");
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return 1;
=A0=A0=A0 }
=A0=A0=A0 strncpy(ifr.ifr_name, "rteth0", IFNAMSIZ);
=A0=A0=A0 if (ioctl(sock, SIOCGIFINDEX, &ifr) < 0) {
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 perror("cannot get interface index");
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 close(sock);
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 return 1;
=A0=A0 =A0=A0=A0 }
=A0=A0=A0 =A0addr.sll_family=A0=A0 =3D AF_PACKET;
=A0=A0=A0=A0=A0=A0=A0 addr.sll_protocol =3D htons(ETH_P_ALL);
=A0=A0=A0 addr.sll_pkttype=A0 =3D PACKET_OTHERHOST;
=A0=A0=A0=A0=A0=A0=A0 addr.sll_ifindex=A0 =3D ifr.ifr_ifindex;

=A0=A0=A0=A0=A0=A0=A0 if (bind(sock, (struct sockaddr *)&addr, sizeof(addr)=
) < 0) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 perror("cannot bind");
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 close(sock);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 1;
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=20
=A0=A0=A0 rt_task_create(&demo_task, "mytask", 0, 99, 0);
=A0=A0=A0 rt_task_start(&demo_task, &demo, NULL);=A0=A0=A0=A0=A0=20
=A0=A0=A0 return 1;
}

### demo_use.c ###
int main( int argc, char * argv[] )
{
=A0=A0=A0 my_send();
=A0=A0=A0 pause();=A0=A0=A0=20
=A0=A0=A0 return 1;=A0=A0=A0=20
}

## Makefile ###
CC =3D gcc
AR =3D ar cru
SOFLAGS =3D -shared -Wl
CFLAGS =3D -I/usr/xenomai/include -I/usr/xenomai/include/posix -D_GNU_SOURC=
E -D_REENTRANT -D__XENO__ -Wall -g -fPIC -rdynamic -pipe -O2 -fstrict-alias=
ing
LDFLAGS =3D -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthre=
ad_rt -lpthread -lnative -lrt -lstdc++ -ldl
LINKER =3D $(CC)
LINT =3D lint -c
RM =3D /bin/rm -f
LIBOBJS =3D=A0 libsock.o=20
TARGET =3D=A0 libmylibra.so \
=A0=A0=A0 =A0=A0=A0 test=20
all: $(TARGET)
libmylibra.so: $(LIBOBJS)
=A0=A0=A0 $(LINKER) $(SOFLAGS) -o $@ $^ -lc
test: demo_use.o
=A0=A0=A0 $(LINKER) $(LDFLAGS) $^ -L. -lmylibra -o $@
clean:
=A0=A0=A0 @( $(RM) *.o vgcore.* core core.* $(TARGET) )
# make rule
%.o : %.cpp
=A0=A0=A0 $(CC) $(CFLAGS) -c $^ -o $@=A0=A0=A0=20

Please post an excerpt of your code exposing this issue (the library
part, and the program part).

You should note that compiling libraries or programs for Xenomai usually
involves compilation flags obtained with xeno-config.

You should also note that "send()" is a glibc function, so calling a
function with the same name is a bad idea.

--=20
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0=A0=A0Gilles.
=0A=0A=0A      
--0-782961513-1241590147=:25323
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">hi.<br>My program included :<br>+ libsock.c<b=
r>+ demo_use.c<br>+ Makefile<br>i build libsock.c as shared library named l=
ibmylibra.so ( support my_send() function )<br>demo_use.c use my_send() and=
 built with -lmylibra option<br>Thanks for any advise.<br>Luan Dinh<br>PS :=
i also attach the source code of these files <br>######### libsock. c###<br=
>void demo(void *agr)<br>{&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; int len=
,i;<br>&nbsp;&nbsp;&nbsp; rt_task_set_periodic(NULL, TM_NOW, 100000000);<br=
>&nbsp;&nbsp;&nbsp; while (1) {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nb=
sp;&nbsp;&nbsp; rt_task_wait_period(NULL);<br>&nbsp;&nbsp;&nbsp; len =3D se=
nd(sock, data, sizeof(data), 0);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (len &lt; 0)<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; printf("Sent
 Failed...!\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbs=
p;&nbsp; }&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>}<br>/*my_send*/<br>int my_se=
nd()<br>{&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; struct sched_param param=
;// =3D { .sched_priority =3D 1 };&nbsp;&nbsp;&nbsp; &nbsp;<br>&nbsp;&nbsp;=
&nbsp; &nbsp; struct sockaddr_ll addr;<br>&nbsp;&nbsp;&nbsp; &nbsp; struct =
ifreq ifr;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT|MC=
L_FUTURE);&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if ((sock =3D socket(AF=
_PACKET, SOCK_RAW, htons(ETH_P_ALL))) &lt; 0) {<br>&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perror("socket cannot be created");<b=
r>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<b=
r>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; strncpy(ifr.ifr_name, "rteth0"=
, IFNAMSIZ);<br>&nbsp;&nbsp;&nbsp; if (ioctl(sock, SIOCGIFINDEX, &amp;ifr)
 &lt; 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 perror("cannot get interface index");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; close(sock);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return 1;<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; }<br>&nbsp;&nbsp;&nbsp; &nbsp;addr.sll_family&nbsp;&nbsp; =3D AF_PACKET;<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr.sll_protocol =3D htons(E=
TH_P_ALL);<br>&nbsp;&nbsp;&nbsp; addr.sll_pkttype&nbsp; =3D PACKET_OTHERHOS=
T;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr.sll_ifindex&nbsp; =3D=
 ifr.ifr_ifindex;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bin=
d(sock, (struct sockaddr *)&amp;addr, sizeof(addr)) &lt; 0) {<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; perror("cannot bin=
d");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 close(sock);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; return 1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp=
;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; rt_task_create(&amp;demo_task, "mytask=
", 0, 99, 0);<br>&nbsp;&nbsp;&nbsp; rt_task_start(&amp;demo_task, &amp;demo=
, NULL);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; return 1;<br>=
}<br><br>### demo_use.c ###<br>int main( int argc, char * argv[] )<br>{<br>=
&nbsp;&nbsp;&nbsp; my_send();<br>&nbsp;&nbsp;&nbsp; pause();&nbsp;&nbsp;&nb=
sp; <br>&nbsp;&nbsp;&nbsp; return 1;&nbsp;&nbsp;&nbsp; <br>}<br><br>## Make=
file ###<br>CC =3D gcc<br>AR =3D ar cru<br>SOFLAGS =3D -shared -Wl<br>CFLAG=
S =3D -I/usr/xenomai/include -I/usr/xenomai/include/posix -D_GNU_SOURCE -D_=
REENTRANT -D__XENO__ -Wall -g -fPIC -rdynamic -pipe -O2 -fstrict-aliasing<b=
r>LDFLAGS =3D -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpth=
read_rt -lpthread -lnative -lrt -lstdc++ -ldl<br>LINKER =3D $(CC)<br>LINT =
=3D lint
 -c<br>RM =3D /bin/rm -f<br>LIBOBJS =3D&nbsp; libsock.o <br>TARGET =3D&nbsp=
; libmylibra.so \<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; test <br>all: $(=
TARGET)<br>libmylibra.so: $(LIBOBJS)<br>&nbsp;&nbsp;&nbsp; $(LINKER) $(SOFL=
AGS) -o $@ $^ -lc<br>test: demo_use.o<br>&nbsp;&nbsp;&nbsp; $(LINKER) $(LDF=
LAGS) $^ -L. -lmylibra -o $@<br>clean:<br>&nbsp;&nbsp;&nbsp; @( $(RM) *.o v=
gcore.* core core.* $(TARGET) )<br># make rule<br>%.o : %.cpp<br>&nbsp;&nbs=
p;&nbsp; $(CC) $(CFLAGS) -c $^ -o $@&nbsp;&nbsp;&nbsp; <br><br><blockquote =
style=3D"border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding=
-left: 5px;"><div class=3D"plainMail">Please post an excerpt of your code e=
xposing this issue (the library<br>part, and the program part).<br><br>You =
should note that compiling libraries or programs for Xenomai usually<br>inv=
olves compilation flags obtained with xeno-config.<br><br>You should also n=
ote that "send()" is a glibc function, so calling a<br>function with the sa=
me
 name is a bad idea.<br><br>-- <br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;Gilles.<br>=
</div></blockquote></td></tr></table><br>=0A=0A      
--0-782961513-1241590147=:25323--

--0-1587027275-1241590147=:25323
Content-Type: text/plain; name="libsock.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="libsock.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1
ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KCiNpbmNsdWRl
IDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1
ZGUgPG5ldHBhY2tldC9wYWNrZXQuaD4KI2luY2x1ZGUgPG5ldC9ldGhlcm5l
dC5oPgojaW5jbHVkZSA8bmV0L2lmLmg+CiNpbmNsdWRlIDxhcnBhL2luZXQu
aD4KCiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPgojaW5jbHVkZSA8bmF0aXZl
L3RpbWVyLmg+CgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPHB0aHJl
YWQuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8bmV0aW5ldC9l
dGhlci5oPgoKI2luY2x1ZGUgImxpYnNvY2suaCIKCnVuc2lnbmVkIGNoYXIg
YnVmZmVyWzE1MTRdOwp1bnNpZ25lZCBjaGFyIGRhdGFbNjBdID0KezB4ZmYs
MHhmZiwweGZmLDB4ZmYsMHhmZiwweGZmLDB4MDAsMHg2NCwweDY3LDB4Njks
MHg3MywweDZFLDB4ODgsMHhBNCwweDIxLDB4MTAsCgkJMHgwQywweDAwLDB4
MDAsMHgwMCwweDAxLDB4MDAsMHgwNywweDgwLDB4MDAsMHgwMCwweDAwLDB4
MDAsMHgwMCwweDAwLDB4MDAsMHgwMCwKCQkweDAwLDB4MDAsMHgwMCwweDA3
LDB4MDAsMHgwMCwweDAwLDB4MzAsMHgwMSwweDAyLDB4MDAsMHgwMCwweDAw
LDB4MDAsMHgwMCwweDAwLAoJCTB4MDAsMHgwMCwweDAwLDB4MDAsMHgwMCww
eDAwLDB4MDAsMHgwMCwweDAwLDB4MDAsMHgwMCwweDAwfTsKIGludCBzb2Nr
OwpSVF9UQVNLIGRlbW9fdGFzazsKCgoKdm9pZCBzb2NrcHJpbnRmKCkKewoJ
cHJpbnRmKCJ0aGlzIGlzIFNvY2twcmludGYuLi4hXG4iKTsKfQoKdm9pZCBk
ZW1vKHZvaWQgKmFncikKewoJCglpbnQgbGVuLGk7CglydF90YXNrX3NldF9w
ZXJpb2RpYyhOVUxMLCBUTV9OT1csIDEwMDAwMDAwMCk7CgoJd2hpbGUgKDEp
IHsgICAgICAgCglydF90YXNrX3dhaXRfcGVyaW9kKE5VTEwpOwoJbGVuID0g
c2VuZChzb2NrLCBkYXRhLCBzaXplb2YoZGF0YSksIDApOwogICAgICAgIGlm
IChsZW4gPCAwKQoJewoJCXByaW50ZigiU2VudCBGYWlsZWQuLi4hXG4iKTsK
ICAgICAgICAgICAgYnJlYWs7Cgl9CgkKICAgIH0JCgkJCn0KCnZvaWQgY2F0
Y2hfc2lnbmFsKGludCBzaWcpCnsKCWNsb3NlKHNvY2spOwp9CgppbnQgbXlf
c2VuZCgpCnsKCQoJc3RydWN0IHNjaGVkX3BhcmFtIHBhcmFtOy8vID0geyAu
c2NoZWRfcHJpb3JpdHkgPSAxIH07CSAKCSAgc3RydWN0IHNvY2thZGRyX2xs
IGFkZHI7CgkgIHN0cnVjdCBpZnJlcSBpZnI7CQoJbWxvY2thbGwoTUNMX0NV
UlJFTlR8TUNMX0ZVVFVSRSk7CQoJaWYgKChzb2NrID0gc29ja2V0KEFGX1BB
Q0tFVCwgU09DS19SQVcsIGh0b25zKEVUSF9QX0FMTCkpKSA8IDApIHsKCSAg
ICAgICAgcGVycm9yKCJzb2NrZXQgY2Fubm90IGJlIGNyZWF0ZWQiKTsKCSAg
ICAgICAgcmV0dXJuIDE7Cgl9CglzdHJuY3B5KGlmci5pZnJfbmFtZSwgInJ0
ZXRoMCIsIElGTkFNU0laKTsKCWlmIChpb2N0bChzb2NrLCBTSU9DR0lGSU5E
RVgsICZpZnIpIDwgMCkgewogICAgICAgIAlwZXJyb3IoImNhbm5vdCBnZXQg
aW50ZXJmYWNlIGluZGV4Iik7CiAgICAgICAgCWNsb3NlKHNvY2spOwogICAg
ICAgIAlyZXR1cm4gMTsKICAgCX0KCSBhZGRyLnNsbF9mYW1pbHkgICA9IEFG
X1BBQ0tFVDsKICAgICAgICBhZGRyLnNsbF9wcm90b2NvbCA9IGh0b25zKEVU
SF9QX0FMTCk7CglhZGRyLnNsbF9wa3R0eXBlICA9IFBBQ0tFVF9PVEhFUkhP
U1Q7CiAgICAgICAgYWRkci5zbGxfaWZpbmRleCAgPSBpZnIuaWZyX2lmaW5k
ZXg7CgogICAgICAgIGlmIChiaW5kKHNvY2ssIChzdHJ1Y3Qgc29ja2FkZHIg
KikmYWRkciwgc2l6ZW9mKGFkZHIpKSA8IDApIHsKICAgICAgICAgICAgcGVy
cm9yKCJjYW5ub3QgYmluZCIpOwogICAgICAgICAgICBjbG9zZShzb2NrKTsK
ICAgICAgICAgICAgcmV0dXJuIDE7CiAgICAgICAgfQoJCglydF90YXNrX2Ny
ZWF0ZSgmZGVtb190YXNrLCAibXl0YXNrIiwgMCwgOTksIDApOwoJcnRfdGFz
a19zdGFydCgmZGVtb190YXNrLCAmZGVtbywgTlVMTCk7CQoJcGF1c2UoKTsK
CXJ0X3Rhc2tfZGVsZXRlKCZkZW1vX3Rhc2spOwoJcmV0dXJuIDE7Cn0K

--0-1587027275-1241590147=:25323
Content-Type: text/plain; name="demo_use.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="demo_use.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1
ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KCiNpbmNsdWRl
IDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1
ZGUgPG5ldHBhY2tldC9wYWNrZXQuaD4KI2luY2x1ZGUgPG5ldC9ldGhlcm5l
dC5oPgojaW5jbHVkZSA8bmV0L2lmLmg+CiNpbmNsdWRlIDxhcnBhL2luZXQu
aD4KCiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPgojaW5jbHVkZSA8bmF0aXZl
L3RpbWVyLmg+CgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPHB0aHJl
YWQuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8bmV0aW5ldC9l
dGhlci5oPgoKI2luY2x1ZGUgInRlc3Rkb20uaHBwIgojaW5jbHVkZSAibGli
c29jay5oIgoKaW50IG1haW4oIGludCBhcmdjLCBjaGFyICogYXJndltdICkN
CnsKCW15X3NlbmQoKTsKCXBhdXNlKCk7CQoJcmV0dXJuIDE7CQp9Cg==

--0-1587027275-1241590147=:25323
Content-Type: application/octet-stream; name=Makefile
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Makefile"

Q0MgPSBnY2MKQVIgPSBhciBjcnUKI0NGTEFHUyA9IC1XYWxsIC1EX1JFRU5U
UkFOVCAtRF9HTlVfU09VUkNFIC1nIC1mUElDClNPRkxBR1MgPSAtc2hhcmVk
IC1XbAojTERGTEFHUyA9IC1sc3RkYysrCgpDRkxBR1MgPSAtSS91c3IveGVu
b21haS9pbmNsdWRlIC1JL3Vzci94ZW5vbWFpL2luY2x1ZGUvcG9zaXggLURf
R05VX1NPVVJDRSAtRF9SRUVOVFJBTlQgLURfX1hFTk9fXyAtV2FsbCAtZyAt
ZlBJQyAtcmR5bmFtaWMgLXBpcGUgLU8yIC1mc3RyaWN0LWFsaWFzaW5nCkxE
RkxBR1MgPSAtV2wsQC91c3IveGVub21haS9saWIvcG9zaXgud3JhcHBlcnMg
LUwvdXNyL3hlbm9tYWkvbGliIC1scHRocmVhZF9ydCAtbHB0aHJlYWQgLWxu
YXRpdmUgLWxydCAtbHN0ZGMrKyAtbGRsDQoKCkxJTktFUiA9ICQoQ0MpCkxJ
TlQgPSBsaW50IC1jClJNID0gL2Jpbi9ybSAtZgoKaWZlcSAoJChvcmlnaW4g
dmVyc2lvbiksIHVuZGVmaW5lZCkKCXZlcnNpb24gPSAwLjQKZW5kaWYKCiMt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKTElCT0JKUyA9ICBsaWJzb2NrLm8g
CgoKVEFSR0VUID0gIGxpYm15bGlicmEuc28gXAoJCXRlc3QgCgojVEFSR0VU
ID0gIHRlc3QKIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgphbGw6ICQoVEFS
R0VUKQoKI2xpYm15bGlicmEuc286ICQoTElCT0JKUykKIwkkKExJTktFUikg
JChTT0ZMQUdTKSAkXiAtbyAkQCAtbGMKCmxpYm15bGlicmEuc286ICQoTElC
T0JKUykKCSQoTElOS0VSKSAkKFNPRkxBR1MpIC1vICRAICReIC1sYwoKCiMk
KFRBUkdFVCk6ICQoTElCT0JKUykKIwkkKExJTktFUikgJChMREZMQUdTKSAk
KExJQk9CSlMpIC1vICQoVEFSR0VUKQp0ZXN0OiBkZW1vX3VzZS5vCgkkKExJ
TktFUikgJChMREZMQUdTKSAkXiAtTC4gLWxteWxpYnJhIC1vICRACmNsZWFu
OgoJQCggJChSTSkgKi5vIHZnY29yZS4qIGNvcmUgY29yZS4qICQoVEFSR0VU
KSApCgojLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCiMgbWFrZSBydWxlCiUu
byA6ICUuY3BwCgkkKENDKSAkKENGTEFHUykgLWMgJF4gLW8gJEAJCg==

--0-1587027275-1241590147=:25323--

