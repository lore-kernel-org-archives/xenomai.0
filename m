Message-ID: <535588B2.90205@xenomai.org>
Date: Mon, 21 Apr 2014 23:08:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5352BA1D.7070707@xenomai.org> <5355705B.5010604@steinkuehler.net>
 <5355728F.80507@xenomai.org> <535573FD.6050308@steinkuehler.net>
In-Reply-To: <535573FD.6050308@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Pre/Post patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/21/2014 09:39 PM, Charles Steinkuehler wrote:
> On 4/21/2014 2:33 PM, Gilles Chanteperdrix wrote:
>> On 04/21/2014 09:24 PM, Charles Steinkuehler wrote:
>>>> 
>>> The next problem comes when building the kernel, I get an
>>> undefined warning from the raid456.ko module (see below).  I'll
>>> keep plugging away, but any advice would be appreciated.
>> 
>> probably something wrong with the configuration. Why do you need
>> raid 4, 5, 6 anyway?
> 
> I don't, of course, it's just what the config from RCN's build
> scripts has setup for by default.
> 
>> In a first step, you should work with a standard configuraiton,
>> such as omap2plus_defconfig, or better, if you have it, with a
>> minimal configuration suited for your board, which will avoid:
>> 
>>> (...) MODPOST 1950 modules
>> 
>> and build a kernel in just a few minutes.
> 
> As mentioned, I'm still plugging along, and mostly learning as I
> go.
> 
> Thanks for the breadcrumbs!  :)

Our users have evolved. Somewhere along the road, Linux users stopped
being used to configuring their kernel, and we did not notice. I hope
to be able to propose something soon to help this situation.

Anyway, start with an unpatched kernel, tune the configuration until
you get a kernel which compiles and runs.

Then merge with the I-pipe tree. If the same configuration (minus the
usual forbidden options) does not compile, then there may be a problem
in the I-pipe tree.

Something to definitely disable for the time being is context tracking
(and so CONFIG_NOHZ_FULL).


-- 
                                                                Gilles.

