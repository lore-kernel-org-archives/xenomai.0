Message-ID: <52BEE319.7000606@openwide.fr>
Date: Sat, 28 Dec 2013 15:41:29 +0100
From: Romain Naour <romain.naour@openwide.fr>
MIME-Version: 1.0
References: <1388233874-6599-1-git-send-email-romain.naour@openwide.fr>
 <52BEC7B4.8080505@xenomai.org> <52BECF88.6080408@openwide.fr>
 <52BED3F2.1020402@xenomai.org>
In-Reply-To: <52BED3F2.1020402@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCH 0/1] armv5tej support in xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Le 28/12/2013 14:36, Gilles Chanteperdrix a écrit :
> On 12/28/2013 02:18 PM, Romain Naour wrote:
>> Le 28/12/2013 13:44, Gilles Chanteperdrix a écrit :
>>> On 12/28/2013 01:31 PM, Romain Naour wrote:
>>>> Hi Gilles,
>>>>
>>>> Can confirm that the armv5tej architecture is supported by xenomai ?
>>>>
>>>> There are currently some compilation errors like this one on buildroot's autobuilder:
>>>> http://autobuild.buildroot.net/results/e3b/e3b534dafb6dd7d788b0c3629ccc0b25702790f0/build-end.log
>>>>
>>>> This error is fixed by the following path.
>>> This fixes xenomai build issue, yes, but I have no idea how xenomai
>>> behaves with programs using the jazelle instruction set.
>> I don't know either.
>>> Does gcc generate jazelle instructions now?
>>>
>> I don't think so.
>> I don't know much about jazelle instructions set.
> My point being, unless I am mistaken, the J in arm5TEJ means "jazelle".
> So, what is the point of generating a compiler for this architecture if
> you do not use the corresponding instructions?
>
>
Jazelle instructions seems to be only used by a JVM, not by gcc.
So, in the current case, the cpu jazelle support is useless without a JVM.

Best regards,
Romain Naour

