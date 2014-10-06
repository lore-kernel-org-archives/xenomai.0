Message-ID: <5432B5AC.6090603@xenomai.org>
Date: Mon, 06 Oct 2014 17:30:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5431959D.8060504@xenomai.org>
 <20141006134448.GU4435@csclub.uwaterloo.ca> <5432AC79.2030909@grinta.net>
 <201410061712.41297.leo@alaxarxa.net>
In-Reply-To: <201410061712.41297.leo@alaxarxa.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [ANNOUNCE] Xenomai 3.0-rc1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, xenomai@xenomai.org

On 10/06/2014 05:12 PM, Leopold Palomo-Avellaneda wrote:
> A Dilluns, 6 d'octubre de 2014, Daniele Nicolodi va escriure:
>> On 06/10/14 15:44, Lennart Sorensen wrote:
>>> On Mon, Oct 06, 2014 at 10:51:34AM +0200, Gilles Chanteperdrix wrote:
>>>> As you can see in the archive, rtnet is not there. But the work is
>>>> not finished, that is what "candidate release" means.
>>>
>>> Where I work, a release candidate is one that could be released fully
>>> feature complete if no bugs are found.  A work in progress is a beta.
>>> As the name says, it is a candidate for a release.

Ok, but the RTnet port adds functionality, with little chances to break
anything else. So, we do not risk much by adding it late in the release
cycle (only to release something broken, but since it was not there in
the first place this does not count as a regression).


>>> So this would be a xenomai 3.0 beta then.
>>
>> As far as I know rtnet is not part of the Xenomai project, but rather a
>> separate project, therefore I don't see how the lack of an rtnet release
>> working with xenomai 3.0 can in any way affect the xenomai release.
>>
> 
> I'm sorry for the thread. Gilles and I interchanged some private mails some 
> days ago and Gilles told me that he has in his todo list to work with RTNET 
> for Xenomai 3.
> 
> However, I don't know which part must be upgraded: RTDM in Xenomai 3 to be 
> used by Rtnet or Rtnet to use Xenomai 3. Anyway, the current version of rtnet 
> cannot work with Xenomai 3. Probably it was upgrade Rtnet.

RTnet must be rebased on the RTDM API changes. At this chance, we plan
to integrate this new RTnet into Xenomai, to ease the maintenance of
RTnet (at least the one for xenomai).


> Till I cannot upgrade rtnet I cannot test xenomai 3.

It would be nice if you could download it, and run xeno-test, to see if
you do not observe any regression on your hardware. Using the
"live-initramfs" to boot off an USB key should make this task really easy.


-- 
                                                                Gilles.

