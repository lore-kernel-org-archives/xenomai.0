Message-ID: <b647ffbd0608210136w7ca05265o5ef930c1bee24d65@domain.hid>
Date: Mon, 21 Aug 2006 10:36:58 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_27663_31879422.1156149418607"
Subject: [Xenomai-core] [patch, minor] xnpipe_recv and
	xntimer_get_timeout_periodic()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_27663_31879422.1156149418607
Content-Type: multipart/alternative; 
	boundary="----=_Part_27664_277728.1156149418607"

------=_Part_27664_277728.1156149418607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[ resent. subject was broken ]

------------------------------------


Hello,

[ pipe.c.patch ]  update the "timeout" variable so that the remaining
timeout is used in case of consequent xnsynch_sleep_on() calls.

As I understand that may indeed happen in case when another thread "steals"
data while this one waits to be scheduled in.

[ timer.c.patch] xnticks_t is unsigned while (as I understand)
"xntlholder_date(&timer->plink) - nkpod->jiffies" can be negative.
In this case, some positive big number is returned and any code that relies
on xnthread_timeout() or xntimer_get_timeout() and runs over periodic mode
won't work properly (e.g. xnsynch_sleep_on() and xnpipe_recv() now). Not
sure 1 should be returned in this case (so far I just did it the same way as
xntimer_get_timeout_aperiodic()), I guess 0 would be better in both cases.

At least in theory, 1 may cause an (even) infinite loop in xnpipe_recv() as
I don't like a check for "timeout > 1" to be placed there. It's something
that should be decided at the timer layer - I mean, whether it's too late to
sleep or not.

hope, I haven't overlooked anything this time :o)


-- 
Best regards,
Dmitry Adamushko

------=_Part_27664_277728.1156149418607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>[ resent. subject was broken ]<br>
<br>
------------------------------------<br><span class="gmail_quote"><br></span><div><br>
Hello,<br>
<br>
[ pipe.c.patch ]&nbsp; update the &quot;timeout&quot; variable so that the
remaining timeout is used in case of consequent xnsynch_sleep_on()
calls.<br>
<br>
As I understand that may indeed happen in case when another thread &quot;steals&quot; data while this one waits to be scheduled in.<br>
<br>
[ timer.c.patch] xnticks_t is unsigned while (as I understand)
&quot;xntlholder_date(&amp;timer-&gt;plink) - nkpod-&gt;jiffies&quot; can be
negative.<br>
In this case, some positive big number is returned and any code that
relies on xnthread_timeout() or xntimer_get_timeout() and runs over
periodic mode won't work properly (e.g. xnsynch_sleep_on() and
xnpipe_recv() now). Not sure 1 should be returned in this case (so far
I just did it the same way as xntimer_get_timeout_aperiodic()), I guess
0 would be better in both cases.<br>
<br>
At least in theory, 1 may cause an (even) infinite loop in
xnpipe_recv() as I don't like a check for &quot;timeout &gt; 1&quot; to be placed
there. It's something that should be decided at the timer layer - I
mean, whether it's too late to sleep or not.<br>
<br>
hope, I haven't overlooked anything this time :o)<br>
<br>
<br>-- <br>Best regards,<br></div><div><span class="sg">Dmitry Adamushko<br>
<br>
</span></div><br>

------=_Part_27664_277728.1156149418607--

------=_Part_27663_31879422.1156149418607
Content-Type: text/x-patch; name=pipe.c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_er4jzh66
Content-Disposition: attachment; filename="pipe.c.patch"

LS0tIHBpcGUtU1ZOLmMJMjAwNi0wOC0yMCAxNTowNDoyNS4wMDAwMDAwMDAgKzAyMDAKKysrIHBp
cGUuYwkyMDA2LTA4LTIwIDIxOjI5OjU1LjAwMDAwMDAwMCArMDIwMApAQCAtNDUwLDYgKzQ1MCw5
IEBAIHNzaXplX3QgeG5waXBlX3JlY3YoaW50IG1pbm9yLCBzdHJ1Y3QgeG4KIAkJCXJldCA9IC1F
SURSTTsKIAkJCWdvdG8gdW5sb2NrX2FuZF9leGl0OwogCQl9CisKKwkJLyogcmVtYWluaW5nIHRp
bWVvdXQgKi8JCQorCQl0aW1lb3V0ID0geG50aHJlYWRfdGltZW91dCh0aHJlYWQpOwogCX0KIAog
CSpwbWggPSBsaW5rMm1oKGhvbGRlcik7Cg==
------=_Part_27663_31879422.1156149418607
Content-Type: text/x-patch; name=timer.c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_er4k010m
Content-Disposition: attachment; filename="timer.c.patch"

LS0tIHRpbWVyLVNWTi5jCTIwMDYtMDgtMjAgMTU6NTA6MTguMDAwMDAwMDAwICswMjAwCisrKyB0
aW1lci5jCTIwMDYtMDgtMjAgMTU6NTQ6MzAuMDAwMDAwMDAwICswMjAwCkBAIC0zMTMsNyArMzEz
LDEyIEBAIHN0YXRpYyB4bnRpY2tzX3QgeG50aW1lcl9nZXRfZGF0ZV9wZXJpb2QKIAogc3RhdGlj
IHhudGlja3NfdCB4bnRpbWVyX2dldF90aW1lb3V0X3BlcmlvZGljKHhudGltZXJfdCAqdGltZXIp
CiB7Ci0JcmV0dXJuIHhudGxob2xkZXJfZGF0ZSgmdGltZXItPnBsaW5rKSAtIG5rcG9kLT5qaWZm
aWVzOworCXhudGlja3NfdCBub3cgPSBua3BvZC0+amlmZmllczsKKwkKKwlpZiAoeG50bGhvbGRl
cl9kYXRlKCZ0aW1lci0+cGxpbmspIDwgbm93KQorCQlyZXR1cm4gMTsJLyogV2lsbCBlbGFwc2Ug
c2hvcnRseS4gKi8KKwkKKwlyZXR1cm4geG50bGhvbGRlcl9kYXRlKCZ0aW1lci0+cGxpbmspIC0g
bm93OwogfQogCiBzdGF0aWMgeG50aWNrc190IHhudGltZXJfZ2V0X3Jhd19leHBpcnlfcGVyaW9k
aWMoeG50aW1lcl90ICp0aW1lcikK
------=_Part_27663_31879422.1156149418607--

