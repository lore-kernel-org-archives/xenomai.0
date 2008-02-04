Message-ID: <47A6FCD2.3070709@domain.hid>
Date: Mon, 04 Feb 2008 12:53:54 +0100
From: Soft Axel <softaxel@domain.hid>
MIME-Version: 1.0
References: <d3f72a390802010108l4f24cc4bq81272fdae55089e9@domain.hid>	
	<2ff1a98a0802010120u6fdf215apf0a542e0c2b2bcff@domain.hid>	
	<d3f72a390802010142g3ac085b5qb2104ccd108796ec@domain.hid>	
	<2ff1a98a0802010153l70062d8eo41c709715ad4fcdb@domain.hid>	
	<47A2EE40.2070602@domain.hid>
	<2ff1a98a0802010200q981e76fkd2340c6ba7796157@domain.hid>
In-Reply-To: <2ff1a98a0802010200q981e76fkd2340c6ba7796157@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------080701090609010704010406"
Subject: Re: [Xenomai-core] rt_task_sleep doesn't work with round robin
	scheduling
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080701090609010704010406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix ha scritto:
> On Fri, Feb 1, 2008 at 11:02 AM, Soft Axel <softaxel@domain.hid> wrote:
>   
>>  Gilles Chanteperdrix ha scritto:
>>
>>  On Fri, Feb 1, 2008 at 10:42 AM, axel axel <softaxel@domain.hid> wrote:
>>
>>
>>  2008/2/1, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>>
>>
>>  On Fri, Feb 1, 2008 at 10:08 AM, axel axel <softaxel@domain.hid> wrote:
>>
>>
>>  Hi,
>>
>> i try to use rt_task_sleep( 10000000 ) in a user-space task under
>> round-robin scheduling but doesnt' work.
>>
>>  Do not forget that the number passed to rt_task_sleep is a count of
>> ticks (and documented as such), so, if you want to sleep for 10ms, you
>> should call:
>> rt_task_sleep(rt_timer_ns2ticks(10000000))
>>
>>  i try also this but nothing is changed.
>>
>>  Of course, but about the other question: do you observe the same
>> behaviour with xenomai trunk ?
>>
>>
>>  What do you mean  xenomai trunk ?
>>
>>  this is my actual configuration:
>>   - xenomai-2.4-rc5
>>   - kernel 2.6.20.4 arm cirrus ep9315 patched
>>
>>  have i try with xenomai 2.4.1 ?
>>     
>
> No, please try Xenomai trunk:
> https://gna.org/svn/?group=xenomai
>
>   

Yes, it works.

But i have one question.
The main trunk is stable or every change is uploaded ?

For me it's very important because i can't upgrade the board very 
frequently.

Roberto



--------------080701090609010704010406
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Gilles Chanteperdrix ha scritto:
<blockquote
 cite="mid:2ff1a98a0802010200q981e76fkd2340c6ba7796157@domain.hid"
 type="cite">
  <pre wrap="">On Fri, Feb 1, 2008 at 11:02 AM, Soft Axel <a class="moz-txt-link-rfc2396E" href="mailto:softaxel@domain.hid">&lt;softaxel@domain.hid&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap=""> Gilles Chanteperdrix ha scritto:

 On Fri, Feb 1, 2008 at 10:42 AM, axel axel <a class="moz-txt-link-rfc2396E" href="mailto:softaxel@domain.hid">&lt;softaxel@domain.hid&gt;</a> wrote:


 2008/2/1, Gilles Chanteperdrix <a class="moz-txt-link-rfc2396E" href="mailto:gilles.chanteperdrix@xenomai.org">&lt;gilles.chanteperdrix@xenomai.org&gt;</a>:


 On Fri, Feb 1, 2008 at 10:08 AM, axel axel <a class="moz-txt-link-rfc2396E" href="mailto:softaxel@domain.hid">&lt;softaxel@domain.hid&gt;</a> wrote:


 Hi,

i try to use rt_task_sleep( 10000000 ) in a user-space task under
round-robin scheduling but doesnt' work.

 Do not forget that the number passed to rt_task_sleep is a count of
ticks (and documented as such), so, if you want to sleep for 10ms, you
should call:
rt_task_sleep(rt_timer_ns2ticks(10000000))

 i try also this but nothing is changed.

 Of course, but about the other question: do you observe the same
behaviour with xenomai trunk ?


 What do you mean  xenomai trunk ?

 this is my actual configuration:
  - xenomai-2.4-rc5
  - kernel 2.6.20.4 arm cirrus ep9315 patched

 have i try with xenomai 2.4.1 ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
No, please try Xenomai trunk:
<a class="moz-txt-link-freetext" href="https://gna.org/svn/?group=xenomai">https://gna.org/svn/?group=xenomai</a>

  </pre>
</blockquote>
<br>
Yes, it works.<br>
<br>
But i have one question. <br>
The main trunk is stable or every change is uploaded ?<br>
<br>
For me it's very important because i can't upgrade the board very
frequently.<br>
<br>
Roberto<br>
<br>
<br>
</body>
</html>

--------------080701090609010704010406--

