Message-ID: <4DCA52E8.80904@domain.hid>
Date: Wed, 11 May 2011 11:12:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz><1303849652.1961.7.camel@domain.hid><1183078C0D064042B3AD2D03E3859EF174E3E4@domain.hid><1183078C0D064042B3AD2D03E3859EF174E43D@AREXCH02.mra.roland-man.biz><1303940558.1932.33.camel@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E5BC@AREXCH02.mra.roland-man.biz><1183078C0D064042B3AD2D03E3859EF174E826@domain.hid>	<4DBFE062.3020902@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E87B@AREXCH02.mra.roland-man.biz>	<4DC03CE8.4050608@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E92F@AREXCH02.mra.roland-man.biz>	<4DC0F4E0.2070707@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174EA21@domain.hid>	<4DC25C69.5020001@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174ECBA@AREXCH02.mra.roland-man.biz>
In-Reply-To: <1183078C0D064042B3AD2D03E3859EF174ECBA@AREXCH02.mra.roland-man.biz>
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

On 05/09/2011 09:36 AM, dietmar.schindler@domain.hid wrote:
>> From: Gilles Chanteperdrix
>> [mailto:gilles.chanteperdrix@xenomai.org] Sent: Thursday, May 05,
>> 2011 10:15 AM ... You can provide the readv implementation, and
>> implement read in terms of readv by passing an iovec with just one
>> buffer. Please also try and make the code a bit more readable than
>> in the previous patch, with only one statement and one "if" by
>> line.
> 
> Hello,
> 
> thank you for your suggestions. I now remade the patch accordingly.
> If you have further improvements to suggest, please let me know.

I am sorry to ask you to change your patch again, but the loop is quite
hard to understand. It would be nice if you could use a simple loops
which copies the pieces of the iovec. So, maybe use two nested loops.

-- 
					    Gilles.

