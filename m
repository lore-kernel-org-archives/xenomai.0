Message-ID: <b647ffbd0706190452g16e98684p13873b09f48eb185@domain.hid>
Date: Tue, 19 Jun 2007 13:52:20 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <46778964.3070608@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_101078_6791672.1182253940766"
References: <OF815057E3.6D5C9810-ONC12572FF.00287AFE-C12572FF.0028A289@domain.hid>
	<46778964.3070608@domain.hid>
Subject: Re: [Xenomai-help] xeno-2.3.1 shared interrups BUG?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: apittaluga@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_101078_6791672.1182253940766
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 19/06/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> apittaluga@domain.hid wrote:
> > Hi,
> > running a simple test application which spawns a periodic task writing on a
> > serial interface
> > the system hangs performing the rt_dev_close.
> > The test program ran fine with xeno 2.2.6 with "Shared Interrupts" enabled,
> > so as with
> > xeno 2.3.1 with "Shared Interrupts" disabled. It fails with xeno 2.3.1 with
> > "Shared Interrupts" enabled, so the problem seems to be in the shared
> > interrupts handling area.
> > kernel is 2.6.20 adeos patched
> >
> > Any suggestion?

Does the fix below eliminate the problem?

The problem (allegedly) is cause by the following reinitialization at
the end of the loop:

...
                if (!(intr = intr->next))
                        intr = shirq->handlers;
...

'end' may point to some of the elements ... and shirq->handlers may
become NULL (all elements have been deleted)..

(white-space damaged version.. enclosed a normal one)

--- ksrc/nucleus/intr.c-orig    2007-06-19 13:44:55.090623404 +0200
+++ ksrc/nucleus/intr.c 2007-06-19 13:45:53.867440067 +0200
@@ -273,7 +273,7 @@ static void xnintr_edge_shirq_handler(un
        xnintr_shirq_lock(shirq);
        intr = shirq->handlers;

-       while (intr != end) {
+       while (intr && intr != end) {
                int ret, code;

                xnstat_runtime_switch(sched,


-- 
Best regards,
Dmitry Adamushko

------=_Part_101078_6791672.1182253940766
Content-Type: text/x-patch; name=fix-edge_shared_intr.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f34bd7yf
Content-Disposition: attachment; filename="fix-edge_shared_intr.patch"

LS0tIGtzcmMvbnVjbGV1cy9pbnRyLmMtb3JpZwkyMDA3LTA2LTE5IDEzOjQ0OjU1LjA5MDYyMzQw
NCArMDIwMAorKysga3NyYy9udWNsZXVzL2ludHIuYwkyMDA3LTA2LTE5IDEzOjQ1OjUzLjg2NzQ0
MDA2NyArMDIwMApAQCAtMjczLDcgKzI3Myw3IEBAIHN0YXRpYyB2b2lkIHhuaW50cl9lZGdlX3No
aXJxX2hhbmRsZXIodW4KIAl4bmludHJfc2hpcnFfbG9jayhzaGlycSk7CiAJaW50ciA9IHNoaXJx
LT5oYW5kbGVyczsKIAotCXdoaWxlIChpbnRyICE9IGVuZCkgeworCXdoaWxlIChpbnRyICYmIGlu
dHIgIT0gZW5kKSB7CiAJCWludCByZXQsIGNvZGU7CiAKIAkJeG5zdGF0X3J1bnRpbWVfc3dpdGNo
KHNjaGVkLAo=
------=_Part_101078_6791672.1182253940766--

