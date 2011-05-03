Message-ID: <4DBFE062.3020902@domain.hid>
Date: Tue, 03 May 2011 13:00:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz><1303849652.1961.7.camel@domain.hid><1183078C0D064042B3AD2D03E3859EF174E3E4@domain.hid><1183078C0D064042B3AD2D03E3859EF174E43D@AREXCH02.mra.roland-man.biz><1303940558.1932.33.camel@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E5BC@AREXCH02.mra.roland-man.biz>
	<1183078C0D064042B3AD2D03E3859EF174E826@domain.hid>
In-Reply-To: <1183078C0D064042B3AD2D03E3859EF174E826@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] message pipe message boundaries
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: dietmar.schindler@domain.hid
Cc: xenomai@xenomai.org

On 05/03/2011 10:15 AM, dietmar.schindler@domain.hid wrote:
>> From: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid]
>> On Behalf Of dietmar.schindler@domain.hid
>> Sent: Friday, April 29, 2011 8:31 AM
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] message pipe message boundaries
>>
>>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>>> Sent: Wednesday, April 27, 2011 11:43 PM
>>>
>>> On Wed, 2011-04-27 at 14:22 +0200, dietmar.schindler@domain.hid
>>> wrote:
>>>> ... Wouldn't it be desirable to implement the
>>>> readv file operation in the rtpipe driver so that the guarantee
> "One
>>>> read() per rt_pipe_write()" could cover readv(2) also?
>>>
>>> No objection to merge this. Patch welcome.
>>
>> Well, I'll try to come up with one.
> 
> We at manroland now use (with Xenomai 2.4) the attached patch, which
> implements the readv file operation in the rtpipe driver so that the
> assertion "One read() per rt_pipe_write()" (message boundaries
> preserved) covers readv(2) also.
> 

I think implementing the readv method is sufficient, you do not need to
implement both readv and read.

-- 
                                                                Gilles.

