Message-ID: <463B2B0B.1030006@domain.hid>
Date: Fri, 04 May 2007 07:46:03 -0500
From: Bill Gatliff <bgat@domain.hid>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>		<DD39B5C3F4963040ADC9768BE7E430CB01E43D41@domain.hid>		<1178204088.29605.85.camel@domain.hid>
	<4639FAC7.9060207@domain.hid>	<1178208712.29605.109.camel@domain.hid>
	<463A1174.60105@domain.hid>
In-Reply-To: <463A1174.60105@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------000005080408010202020406"
Subject: Re: [Xenomai-help] Latency calculation and test
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
Cc: Xenomai-help@domain.hid

This is a multi-part message in MIME format.
--------------000005080408010202020406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>   
>> On Thu, 2007-05-03 at 17:07 +0200, Gilles Chanteperdrix wrote:
>>
>> That was not my point. My point was: don't stuff huge semi-random values
>> into /proc/xenomai/latency to work around terrible jittery especially
>> when porting Xenomai over new platforms, because this is _likely_ the
>> sign of something going wrong elsewhere.
>>
>> E.g. An oldish 90Mhz classic pentium exhibits ~25 us core latency
>> figures with Xenomai; some ARM hw may require more because of
>> unfortunate memory sub-systems, but in any case, you have to
>> _understand_ (e.g. using the tracer) why it is so, first.
>>     
>
> I agree. I still have to see for myself why these damned ARMs have such
> high latencies.
>   

Big LDM/STMs with slow memory will do the trick every time.  The CSB637 
has a 100 MHz memory bus, even though the CPU can run at almost 200 MHz.

I think the cache and MMU arrangements have implications, too.  And 
anything tied to NWAIT on that chip (AT91RM9200) drags the system down 
quite easily.

Don't accept those explanations at face value, though.  I'd love to see 
the root cause clearly identified.


b.g.

-- 
Bill Gatliff
bgat@domain.hid


--------------000005080408010202020406
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Gilles Chanteperdrix wrote:
<blockquote cite="mid463A1174.60105@domain.hid" type="cite">
  <pre wrap="">Philippe Gerum wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Thu, 2007-05-03 at 17:07 +0200, Gilles Chanteperdrix wrote:

That was not my point. My point was: don't stuff huge semi-random values
into /proc/xenomai/latency to work around terrible jittery especially
when porting Xenomai over new platforms, because this is _likely_ the
sign of something going wrong elsewhere.

E.g. An oldish 90Mhz classic pentium exhibits ~25 us core latency
figures with Xenomai; some ARM hw may require more because of
unfortunate memory sub-systems, but in any case, you have to
_understand_ (e.g. using the tracer) why it is so, first.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I agree. I still have to see for myself why these damned ARMs have such
high latencies.
  </pre>
</blockquote>
<br>
Big LDM/STMs with slow memory will do the trick every time.&nbsp; The CSB637
has a 100 MHz memory bus, even though the CPU can run at almost 200 MHz.<br>
<br>
I think the cache and MMU arrangements have implications, too.&nbsp; And
anything tied to NWAIT on that chip (AT91RM9200) drags the system down
quite easily.<br>
<br>
Don't accept those explanations at face value, though.&nbsp; I'd love to see
the root cause clearly identified.<br>
<br>
<br>
b.g.<br>
<pre class="moz-signature" cols="72">-- 
Bill Gatliff
<a class="moz-txt-link-abbreviated" href="mailto:bgat@domain.hid">bgat@domain.hid</a>
</pre>
</body>
</html>

--------------000005080408010202020406--

