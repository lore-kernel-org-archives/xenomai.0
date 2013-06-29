Message-ID: <51CEDE55.6030606@xenomai.org>
Date: Sat, 29 Jun 2013 15:17:09 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <201306260906.22955.leo@alaxarxa.net>
	<51CC031A.9030905@xenomai.org>
	<CAMYDobV2YQez7qtcTxxQ1wsL23oPu0sT+WwHsQ6hW18pcgnJkA@mail.gmail.com>
	<201306290134.51737.leo@alaxarxa.net>
In-Reply-To: <201306290134.51737.leo@alaxarxa.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai warn_upon_switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo Avellaneda <leo@alaxarxa.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/29/2013 01:34 AM, Leopold Palomo Avellaneda wrote:
> A Divendres, 28 de juny de 2013, Peter Soetens va escriure:
>> On Thu, Jun 27, 2013 at 11:17 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>>> On 06/27/2013 11:09 AM, Leopold Palomo-Avellaneda wrote:
>>>> AAnd I don't know how to silent (or if is possible) this messages.
>>>
>>> Try disabling CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX if currently set in your
>>> kernel config. If that is still not enough, then you will have to switch
>>> off PTHREAD_WARNSW manually, using pthread_set_mode_np(), for each
>>> thread which triggers this signal.
>>
>> Quoting Gilles:
>> "The point is that these messages are telling you that there is a bug,
>> either in xenomai code (a bug was fixed since xenomai 2.6.2.1 which
>> could explain such a behaviour), or in orocos code. When the bug is
>> fixed the signal will disappear."
>>
>> We're having one thread ( main() ) which is modeswitching all the time
>> since it's doing user IO using the console, filesystem etc.
>>
>> I didn't consider this as a bug, and we only enable PTHREAD_WARNSW for
>> specific threads, where it does matter.
>>
>> I also have the CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX option on in my test
>> system, and I'm not seeing any of these messages (while the MSW
>> increments).
>>
>> So it beats me what is causing these messages in his setup.
>
> :-(
>
> some other people in the orocos list has mention it [1] but I would prefer to
> have a wrong setup than a orocos bug.
>
>> Leo, which version (git hash tag) are you using ?
>
> - Debian Wheezy,
> - kernel 3.5.7, corresponding to the adeos patch provided in that version.
> - xenomai 2.6.2? (downloaded, not git)
>
> Now someone would like to kill me. I don't know if is 2.6.2.1 or 2.6.2. I
> thought that it was 2.6.2.1, but I built the packages some time ago and they
> have been my base, but looking on the dates maybe I'm wrong :-(
>
> How can I know the version of a tree of files of xenomai?
>
> I have not be able to found any changelog in the tar.bz2. ... On monday I
> would repeat all my tests ....
>
> If you want to test it add in you sources list:
>
> ---------------------------
> # Debian-robotics
> deb http://sir.upc.edu/debian-robotics wheezy-robotics main
> deb-src http://sir.upc.edu/debian-robotics wheezy-robotics main
> ---------------------------
> apt-key adv --keyserver pgp.mit.edu --recv-keys 682EC09CF944807E
> apt-get update
> apt-get install linux-image-3.5.7-xenomai-2.6.2.1 libxenomai-dev
>
> about the xenomai package don't trust in the version numbers, because I think
> that,as it was for my personal use, I didn't put 4 numbers. But, I remember
> that 2.6.2 cannot build the debian package and 2.6.2.1 yes.
>
> I have always work with debian packages.
>
> It's too late now but f I did a mistake with the version number I'm really
> embarrassed.
>
> On Monday I will test it all again.

Again, a Gilles mentioned several times already, a sane way to debug 
this issue is to hook the SIGDEBUG signal Xenomai sends your process, 
displaying the reason why it does it, in the signal handler.

Please have a careful look at src/testsuite/latency/latency.c:491, 
function sigdebug(). Add a similar code to your main process, you will 
get the information. From that point, debugging should be 
straightforward. Until then, your might be searching a needle in a haystack.

-- 
Philippe.

