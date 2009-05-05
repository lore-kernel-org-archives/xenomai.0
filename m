In-Reply-To: <4A0040D9.60907@domain.hid>
Message-ID: <OFB15EA397.FEDBD30F-ONC12575AD.004B05A5-C12575AD.004B769C@datacon.at>
From: henning.richter@domain.hid
Date: Tue, 5 May 2009 15:44:16 +0200
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFF3EDFD883358f9e8a93df938690918c4EBBFF3EDFD88335"
Content-Disposition: inline
Subject: Re: [Xenomai-help] gatekeeper/0
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
Cc: xenomai@xenomai.org

--0__=4EBBFF3EDFD883358f9e8a93df938690918c4EBBFF3EDFD88335
Content-type: text/plain; charset=US-ASCII




henning.richter@domain.hid wrote:
>> Hi,
>>
>> running a xenomai task in which I am sending a single Frame (size ~500
>> byte) from my EtherCAT Master to some Beckhoff slaves has latencies
around
>> 200 us.
>> While running that task, top shows that gatekeeper/0 (with RT priority)
has
>> 30% CPU usage.
>> What is the task of this gatekeeper and can this cause my high
latencies?
>
> The gatekeeper is used when a taks is migrating from secondary mode to
> primary mode. The gatekeeper itself can not cause the high latencies,
> but the fact that a task runs in secondary mode can.
>
> To check if this is what happens, check the MSW column in
> /proc/xenomai/stat for the thread which has latencies issues. If MSW is
> increasing then you have a problem.

> To find where your thread switches to secondary mode, use the technique
> demonstrated in examples/native/sigxcpu.c.

--
                                                 Gilles.

So thank your for defining my problem.
Now I am sure that there my thread is switching to secondary mode
as the MSW column increases rapidly while running my application.
Can I also use the ipipe tracer or LTTng to find the place where it
switches the modes as I don't have the
xenomai examples installed.

Henning
--0__=4EBBFF3EDFD883358f9e8a93df938690918c4EBBFF3EDFD88335
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>henning.richter@domain.hid wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt; <br>
&gt;&gt; running a xenomai task in which I am sending a single Frame (size ~500<br>
&gt;&gt; byte) from my EtherCAT Master to some Beckhoff slaves has latencies around<br>
&gt;&gt; 200 us.<br>
&gt;&gt; While running that task, top shows that gatekeeper/0 (with RT priority) has<br>
&gt;&gt; 30% CPU usage.<br>
&gt;&gt; What is the task of this gatekeeper and can this cause my high latencies?<br>
&gt;<br>
&gt; The gatekeeper is used when a taks is migrating from secondary mode to<br>
&gt; primary mode. The gatekeeper itself can not cause the high latencies,<br>
&gt; but the fact that a task runs in secondary mode can.<br>
&gt;<br>
&gt; To check if this is what happens, check the MSW column in<br>
&gt; /proc/xenomai/stat for the thread which has latencies issues. If MSW is<br>
&gt; increasing then you have a problem.<br>
<br>
&gt; To find where your thread switches to secondary mode, use the technique<br>
&gt; demonstrated in examples/native/sigxcpu.c.<br>
<br>
-- <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br>
</tt><br>
So thank your for defining my problem.<br>
Now I am sure that there my thread is switching to secondary mode<br>
as the MSW column increases rapidly while running my application.<br>
Can I also use the ipipe tracer or LTTng to find the place where it switches the modes as I don't have the <br>
xenomai examples installed.<br>
<br>
Henning</body></html>
--0__=4EBBFF3EDFD883358f9e8a93df938690918c4EBBFF3EDFD88335--


