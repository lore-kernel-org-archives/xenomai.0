MIME-Version: 1.0
Date: Fri, 13 Feb 2009 08:57:37 +0200
Message-ID: <f83fbfb0902122257r72aa1d5boc8ac8fd2460c3939@domain.hid>
From: Michael Smith <2michael.smith@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5bf7222bb030462c75ab6
Subject: [Xenomai-help] Subject: Re:  Known-to-work motherboards?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--001636c5bf7222bb030462c75ab6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

>Gilles Chanteperdrix wrote:
>> Stuart O Anderson wrote:
>>> If there isn't a list online that I've missed, is anyone running
>>> xenomai on a relatively recent machine with 8 or more cores without
>>> problems?  If so, can you provide hardware specs?
>>
>> Xenomai will have scalability problems when running on an 8 cores system
>> (if you intend to run real-time tasks on each of the 8 cores).
>>

>We are running Xenomai on up to 4x4 boxes, but only with 1 or 2 cores
>used by RT tasks. I've some patch hanging around that restricts Xenomai
>(specifically its host timer hook) to a CPU subset in order to mitigate
>the scalability issues - guess I should finally get it in shape and post
it.

>However, my point is: Massive parallel RT is not (yet) feasible with
>Xenomai, but it is no black magic to have massive parallel non-RT load
>living together with confined RT load on the same box.

>Jan

Hi Jan
Just for information, we are running quad core and dual core machines with
Xenomai and RTNet on our system and we are using each of the quad's cores
to the maximum capacities (each running a RT process) and we are getting
incredible
latencies and performance with an optimized system.
I am talking from about the low micro seconds to even a few hundreds of nano
seconds.
I am really impressed with what we can push out of the correct hardware /
Xenomai
combination and also with the multi-processing capabilities of Xenomai.

Regards
Michael Smith

--001636c5bf7222bb030462c75ab6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

&gt;Gilles Chanteperdrix wrote:<br>
&gt;&gt; Stuart O Anderson wrote:<br>
&gt;&gt;&gt; If there isn&#39;t a list online that I&#39;ve missed, is anyo=
ne running<br>
&gt;&gt;&gt; xenomai on a relatively recent machine with 8 or more cores wi=
thout<br>
&gt;&gt;&gt; problems? &nbsp;If so, can you provide hardware specs?<br>
&gt;&gt;<br>
&gt;&gt; Xenomai will have scalability problems when running on an 8 cores =
system<br>
&gt;&gt; (if you intend to run real-time tasks on each of the 8 cores).<br>
&gt;&gt;<br>
<br>
&gt;We are running Xenomai on up to 4x4 boxes, but only with 1 or 2 cores<b=
r>
&gt;used by RT tasks. I&#39;ve some patch hanging around that restricts Xen=
omai<br>
&gt;(specifically its host timer hook) to a CPU subset in order to mitigate=
<br>
&gt;the scalability issues - guess I should finally get it in shape and pos=
t it.<br>
<br>
&gt;However, my point is: Massive parallel RT is not (yet) feasible with<br=
>
&gt;Xenomai, but it is no black magic to have massive parallel non-RT load<=
br>
&gt;living together with confined RT load on the same box.<br>
<br>
&gt;Jan<br><br>Hi Jan <br>Just for information, we are running quad core an=
d dual core machines with<br>Xenomai and RTNet on our system and we are usi=
ng each of the quad&#39;s cores <br>to the maximum capacities (each running=
 a RT process) and we are getting incredible <br>
latencies and performance with an optimized system. <br>I am talking from a=
bout the low micro seconds to even a few hundreds of nano seconds. <br>I am=
 really impressed with what we can push out of the correct hardware / Xenom=
ai <br>
combination and also with the multi-processing capabilities of Xenomai.<br>=
&nbsp;<br>Regards<br>Michael Smith<br><br><br><br><br><br>

--001636c5bf7222bb030462c75ab6--

