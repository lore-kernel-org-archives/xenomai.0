Message-ID: <6132061f0805111302n769b3787oe2f3d14e2123fa59@domain.hid>
Date: Sun, 11 May 2008 17:02:43 -0300
From: "Breno Carneiro Pinheiro" <brenodee@domain.hid>
In-Reply-To: <18466.8349.380119.79195@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11359_22047989.1210536163282"
References: <3d3b73870805061301m4a89029eqa69c17b212274f38@domain.hid>
	<6132061f0805071046h65ce2f7eme4fade4c404223a9@domain.hid>
	<2ff1a98a0805071052g1515edbam19ad164ce2e53b5d@domain.hid>
	<6132061f0805071406p72fde054i68e0d942bcff7748@domain.hid>
	<18466.7374.342618.854340@domain.hid>
	<6132061f0805071427o494b28d3jf0289ef9a195ef90@domain.hid>
	<18466.8349.380119.79195@domain.hid>
Subject: Re: [Xenomai-help] Does Xenomai 2.4.x support Xenomm ?
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

------=_Part_11359_22047989.1210536163282
Content-Type: multipart/alternative; 
	boundary="----=_Part_11360_6940736.1210536163283"

------=_Part_11360_6940736.1210536163283
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, I think I got solved the last error (* ./task_test : error while loading
shared libraries : libnative.so.0 : cannot
 > open shared object file : Not such file or directory*) when I tried to
execute my application below:
#include <sys/mman.h>
#include <native/task.h>
#include <stdio.h>
#define TASK_PRIO  99 /* Highest RT priority */
#define TASK_MODE  0  /* No flags */
#define TASK_STKSZ 0  /* Stack size (use default one) */

RT_TASK task_desc;

void task_body (void *cookie)
 {
     for (;;) {
     printf("%s\n",'a');
     }
 }

int main (int argc, char *argv[])

 {
     int err;

     mlockall(MCL_CURRENT|MCL_FUTURE);

     err = rt_task_create(&task_desc,
                          "MyTaskName",
                          TASK_STKSZ,
                          TASK_PRIO,
                          TASK_MODE);
     if (!err)
         rt_task_start(&task_desc,&task_body,NULL);

     /* ... */
 }

 void cleanup (void)

 {
    rt_task_delete(&task_desc);
 }

I used the Makefile attached!!!
But now, when I execute ./task_test on my environment I got:
*segmentation fault

*Does it any relation with my application?*

*
Thanks,

Breno

------=_Part_11360_6940736.1210536163283
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, I think I got solved the last error (<b> ./task_test : error while loading shared libraries : libnative.so.0 : cannot<br>
&nbsp;&gt; open shared object file : Not such file or directory</b>) when I tried to execute my application below:<br>#include &lt;sys/mman.h&gt;<br>#include &lt;native/task.h&gt;<br>#include &lt;stdio.h&gt; <br>#define TASK_PRIO&nbsp; 99 /* Highest RT priority */<br>
#define TASK_MODE&nbsp; 0&nbsp; /* No flags */<br>#define TASK_STKSZ 0&nbsp; /* Stack size (use default one) */<br>&nbsp;<br>RT_TASK task_desc;<br>&nbsp;<br>void task_body (void *cookie)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp; for (;;) {<br>&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%s\n&quot;,&#39;a&#39;);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;}<br>&nbsp;<br>int main (int argc, char *argv[])<br>&nbsp;<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT|MCL_FUTURE);<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp; err = rt_task_create(&amp;task_desc,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;MyTaskName&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TASK_STKSZ,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TASK_PRIO,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TASK_MODE);<br>&nbsp;&nbsp;&nbsp;&nbsp; if (!err)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_start(&amp;task_desc,&amp;task_body,NULL);<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp; /* ... */<br>
&nbsp;}<br>&nbsp;<br>&nbsp;void cleanup (void)<br><br>&nbsp;{<br>&nbsp;&nbsp;&nbsp; rt_task_delete(&amp;task_desc);<br>&nbsp;}<br>&nbsp;<br>I used the Makefile attached!!!<br>But now, when I execute ./task_test on my environment I got:<br><b>segmentation fault<br><br>
</b>Does it any relation with my application?<b><br><br></b><div class="gmail_quote"><br></div>Thanks,<br><br>Breno<br>

------=_Part_11360_6940736.1210536163283--

------=_Part_11359_22047989.1210536163282
Content-Type: application/octet-stream; name=Makefile
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fg41y5lz0
Content-Disposition: attachment; filename=Makefile

IyMjIyMjIENPTkZJR1VSQVRJT04gIyMjIyMjCgojIyMgTGlzdCBvZiBhcHBsaWNhdGlvbnMgdG8g
YmUgYnVpbGQKI0FQUExJQ0FUSU9OUyA9IHRyaXZpYWwtcGVyaW9kaWMgc2lneGNwdSBydHByaW50
CkFQUExJQ0FUSU9OUyA9IHRhc2tfdGVzdAojIyMgTm90ZTogdG8gb3ZlcnJpZGUgdGhlIHNlYXJj
aCBwYXRoIGZvciB0aGUgeGVuby1jb25maWcgc2NyaXB0LCB1c2UgIm1ha2UgWEVOTz0uLi4iCgoK
IyMjIExpc3Qgb2YgbW9kdWxlcyB0byBiZSBidWlsZApNT0RVTEVTID0KCiMjIyBOb3RlOiB0byBv
dmVycmlkZSB0aGUga2VybmVsIHNvdXJjZSBwYXRoLCB1c2UgIm1ha2UgS1NSQz0uLi4iCgoKCiMj
IyMjIyBVU0VSIFNQQUNFIEJVSUxEIChubyBjaGFuZ2UgcmVxdWlyZWQgbm9ybWFsbHkpICMjIyMj
IwppZmVxICgkKEtFUk5FTFJFTEVBU0UpLCkKaWZuZXEgKCQoQVBQTElDQVRJT05TKSwpCgojIyMg
RGVmYXVsdCBYZW5vbWFpIGluc3RhbGxhdGlvbiBwYXRoCiNYRU5PID89IC91c3IveGVub21haQpY
RU5PID89IC9ob21lL2JyZW5vL0VMREsvcHBjXzZ4eC91c3IvbG9jYWwveGVub21haS8KWEVOT0NP
TkZJRz0kKHNoZWxsIFBBVEg9JChYRU5PKTokKFhFTk8pL2JpbjokKFBBVEgpIHdoaWNoIHhlbm8t
Y29uZmlnIDI+L2Rldi9udWxsKQoKIyMjIFNhbml0eSBjaGVjawppZmVxICgkKFhFTk9DT05GSUcp
LCkKYWxsOjoKCUBlY2hvICI+Pj4gSW52b2tlIG1ha2UgbGlrZSB0aGlzOiBcIm1ha2UgWEVOTz0v
cGF0aC90by94ZW5vLWNvbmZpZ1wiIDw8PCIKCUBlY2hvCmVuZGlmCgpDQz0kKHNoZWxsICQoWEVO
T0NPTkZJRykgLS1jYykKCkNGTEFHUz0kKHNoZWxsICQoWEVOT0NPTkZJRykgLS14ZW5vLWNmbGFn
cykgJChNWV9DRkxBR1MpCgpMREZMQUdTPSQoc2hlbGwgJChYRU5PQ09ORklHKSAtLXhlbm8tbGRm
bGFncykgJChNWV9MREZMQUdTKSAtbG5hdGl2ZQoKIyBUaGlzIGluY2x1ZGVzIHRoZSBsaWJyYXJ5
IHBhdGggb2YgZ2l2ZW4gWGVub21haSBpbnRvIHRoZSBiaW5hcnkgdG8gbWFrZSBsaXZlCiMgZWFz
aWVyIGZvciBiZWdpbm5lcnMgaWYgWGVub21haSdzIGxpYnMgYXJlIG5vdCBpbiBhbnkgZGVmYXVs
dCBzZWFyY2ggcGF0aC4KTERGTEFHUys9LVhsaW5rZXIgLXJwYXRoIC1YbGlua2VyICQoc2hlbGwg
JChYRU5PQ09ORklHKSAtLWxpYmRpcikKCmFsbDo6ICQoQVBQTElDQVRJT05TKQoKY2xlYW46OgoJ
JChSTSkgJChBUFBMSUNBVElPTlMpICoubwoKZW5kaWYKZW5kaWYKCgoKIyMjIyMjIFNQRUNJQUwg
VEFSR0VUIFJVTEVTICMjIyMjIwp0YXNrX3Rlc3Q6IHRhc2tfdGVzdC5jCgkjJChDQykgJChDRkxB
R1MpICQ/ICQoTERGTEFHUykgLWxydGRrIC1vICRACgkkKENDKSAkKENGTEFHUykgJD8gJChMREZM
QUdTKSAtbG5hdGl2ZSAtbyAkQAoKCgojIyMjIyMgS0VSTkVMIE1PRFVMRSBCVUlMRCAobm8gY2hh
bmdlIHJlcXVpcmVkIG5vcm1hbGx5KSAjIyMjIyMKaWZuZXEgKCQoTU9EVUxFUyksKQoKIyMjIERl
ZmF1bHQgdG8gc291cmNlcyBvZiBjdXJyZW50bHkgcnVubmluZyBrZXJuZWwKI0tTUkMgPz0gL2xp
Yi9tb2R1bGVzLyQoc2hlbGwgdW5hbWUgLXIpL2J1aWxkCktTUkMgPz0gL2hvbWUvYnJlbm8vRUxE
Sy9wcGNfNnh4L2xpYi9tb2R1bGVzLyQoc2hlbGwgdW5hbWUgLXIpL2J1aWxkCgpPQkpTICAgICA6
PSAke3BhdHN1YnN0ICUsICUubywgJChNT0RVTEVTKX0KQ0xFQU5NT0QgOj0gJHtwYXRzdWJzdCAl
LCAuJSosICQoTU9EVUxFUyl9ClBXRCAgICAgIDo9ICQoc2hlbGwgaWYgWyAiJCRQV0QiICE9ICIi
IF07IHRoZW4gZWNobyAkJFBXRDsgZWxzZSBwd2Q7IGZpKQoKIyMjIEtlcm5lbCAyLjYKaWZlcSAo
JChmaW5kc3RyaW5nIDIuNiwkKEtTUkMpKSwyLjYpCgpvYmotbSAgICAgICAgOj0gJChPQkpTKQpF
WFRSQV9DRkxBR1MgOj0gLUkkKEtTUkMpL2luY2x1ZGUveGVub21haSAtSSQoS1NSQykvaW5jbHVk
ZS94ZW5vbWFpL3Bvc2l4ICQoQUREX0NGTEFHUykKCmFsbDo6CgkkKE1BS0UpIC1DICQoS1NSQykg
U1VCRElSUz0kKFBXRCkgbW9kdWxlcwoKIyMjIEtlcm5lbCAyLjQKZWxzZQoKQVJDSCAgICA/PSAk
KHNoZWxsIHVuYW1lIC1pKQpJTkNMVURFIDo9IC1JJChLU1JDKS9pbmNsdWRlL3hlbm9tYWkgLUkk
KEtTUkMpL2luY2x1ZGUveGVub21haS9jb21wYXQgLUkkKEtTUkMpL2luY2x1ZGUveGVub21haS9w
b3NpeApDRkxBR1MgICs9ICQoc2hlbGwgJChNQUtFKSAtcyAtQyAkKEtTUkMpIENDPSQoQ0MpIEFS
Q0g9JChBUkNIKSBTVUJESVJTPSQoUFdEKSBtb2R1bGVzKSAkKElOQ0xVREUpCgphbGw6OiAkKE9C
SlMpCgplbmRpZgoKIyMgVGFyZ2V0IGZvciBjYXB0dXJpbmcgMi40IG1vZHVsZSBDRkxBR1MKbW9k
dWxlczoKCUBlY2hvICIkKENGTEFHUykiCgpjbGVhbjo6CgkkKFJNKSAkKENMRUFOTU9EKSAqLm8g
Ki5rbyAqLm1vZC5jIE1vZHVsZSouc3ltdmVycwoJJChSTSkgLVIgLnRtcCoKCmVuZGlmCg==
------=_Part_11359_22047989.1210536163282--

