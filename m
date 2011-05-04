Message-ID: <4DC0F4E0.2070707@domain.hid>
Date: Wed, 04 May 2011 08:40:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz><1303849652.1961.7.camel@domain.hid><1183078C0D064042B3AD2D03E3859EF174E3E4@domain.hid><1183078C0D064042B3AD2D03E3859EF174E43D@AREXCH02.mra.roland-man.biz><1303940558.1932.33.camel@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E5BC@AREXCH02.mra.roland-man.biz><1183078C0D064042B3AD2D03E3859EF174E826@domain.hid>	<4DBFE062.3020902@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E87B@AREXCH02.mra.roland-man.biz>	<4DC03CE8.4050608@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174E92F@AREXCH02.mra.roland-man.biz>
In-Reply-To: <1183078C0D064042B3AD2D03E3859EF174E92F@AREXCH02.mra.roland-man.biz>
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

On 05/04/2011 08:36 AM, dietmar.schindler@domain.hid wrote:
>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
>> Sent: Tuesday, May 03, 2011 7:36 PM
>> ...
>>>> On 05/03/2011 10:15 AM, dietmar.schindler@domain.hid wrote:
>>>>> ...
>>>>> We at manroland now use (with Xenomai 2.4) the attached patch, which
>>>>> implements the readv file operation in the rtpipe driver so that the
>>>>> assertion "One read() per rt_pipe_write()" (message boundaries
>>>>> preserved) covers readv(2) also.
>> ...
>> Unfortunately, the patch as is is a bit hard to read. IMO, only
>> implementing readv will result in a more straight-forward implementation
>> which we could merge.
> 
> I understand. If you prefer, I can provide a patch which multiplies out the functions to a separate readv, though this will result in code duplication of the whole read function. Alternatively, I could comment the changes so that they are easier to read.
> Please let me know which flavour you favour.

What I suggest, is that you make a patch which removes the read
implementation and adds the readv implementation. In this case, the
kernel will use readv to implement read anyway, and there will be no
code duplication.

-- 
                                                                Gilles.

