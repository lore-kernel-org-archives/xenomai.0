Message-ID: <554B651A.9000209@nta-inc.net>
Date: Thu, 07 May 2015 08:14:02 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <554B0C27.5010802@free.fr>
 <20150507090719.GC2099@hermes.click-hack.org>
In-Reply-To: <20150507090719.GC2099@hermes.click-hack.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] v3 heap mem-pool-size
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 05/07/2015 04:07 AM, Gilles Chanteperdrix wrote:
> On Thu, May 07, 2015 at 08:54:31AM +0200, Stéphane ANCELOT wrote:
>> Hi,
>>
>> Is there a better way to raise mem-pool-size other than specifying in
>> cmdline ?
>>
>>     0"007.389| WARNING: [main] heapobj_init() failed for 470 bytes, raise
>> --mem-pool-size?
>
> A command line option is nice, it allows you to do basically
> anything you want by calling your program from a script. What is it
> you want to do that can not be achieved this way?
>

If we don't want to call our application from a script to set appropriate Xenomai parameters, will supplying the --no-auto-init option to xeno-config allow us to set Xenomai run-time options to the desired values by manually calling copperplate_init() from our application?  Are the options that can be passed to copperplate_init() the ones described here [1]?  Do these options apply to applications based on the POSIX skin as well?  If so, I am slightly confused because the documentation (e.g. [2], [3]) that states that all APIs except POSIX are based on the Copperplate library, so it would seem that Copperplate related stuff would not apply to POSIX applications.  I apologize if this is a silly question, but I am still coming up to speed on the new Xenomai 3 architecture.

Thanks,

Jeff

[1] https://xenomai.org/running-applications-with-xenomai-3-x/
[2] http://www.xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.html
[3] https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/

