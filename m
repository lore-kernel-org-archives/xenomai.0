Message-ID: <4E0C581C.5040701@domain.hid>
Date: Thu, 30 Jun 2011 13:03:56 +0200
From: varname <varname@domain.hid>
MIME-Version: 1.0
References: <18837_1309425123_4E0C3DE3_18837_902_2_ECB646CBB62FD044927FDEDF0252D3E701E388DDD283@domain.hid>	<1309426397.2228.2.camel@domain.hid>	<1454_1309428796_4E0C4C3C_1454_4301_1_ECB646CBB62FD044927FDEDF0252D3E701E388DDD4C1@domain.hid>
	<4E0C5400.7060200@domain.hid>
In-Reply-To: <4E0C5400.7060200@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.6 with Valgrind ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> On 06/30/2011 12:13 PM, VEYSSIERE Nicolas wrote:
>> Ok, so is there something that can replace Valgrind and works with Xenomai ?
>>
>> I am using the VxWorks skin.
>>
> You can use valgrind either with Xenomai simulator, but that will not be
> easy, or with Xenomai-solo. But not with the dual-kernel version.

Could you comment on the status of Xenomai-solo? Last time I checked 
(some 7 months ago) it was missing parts of the native skin. I also 
remember the git checkout was not compilable. I'm rather interested in 
using it for (automated) testing purposes, such as memory leak checking.


