Message-ID: <50793CB6.3070708@xenomai.org>
Date: Sat, 13 Oct 2012 12:04:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFNBftf5EYFoSPK3VA4NWA5-eCQVvpOt_uV5Kf8VJ9rAsA5eww@mail.gmail.com>	<CAHQk_AR+n7pq==TSTz5JwVRhg=jOKMXKniGrgdVTVTea5=aq1Q@mail.gmail.com>	<50793B0E.5020002@xenomai.org>
	<CAHQk_ASEpt2Xxr4CN+x17LGRCESqv_4CKHe=5UnmtchakLwFAQ@mail.gmail.com>
In-Reply-To: <CAHQk_ASEpt2Xxr4CN+x17LGRCESqv_4CKHe=5UnmtchakLwFAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Yocto/Openembedded
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Maksym Parkachov <lazy.gopher@gmail.com>
Cc: xenomai@xenomai.org

On 10/13/2012 12:02 PM, Maksym Parkachov wrote:

> Hi Gilles,
> 
>> Adding I-pipe and Xenomai as a single patch to the kernel does not seem
>> the way to go.
>>
>> I would rather have the linux kernel building rules call
>> prepare-kernel.sh to apply the I-pipe patch and setup xenomai links to
>> the xenomai package source directory. It is not really hard, and it
>> makes things way easier to maintain.
> 
> It was just a quick way to get result, when I have time I'll try to
> rework recipe with your suggestions.


No problem, really, it was just a remark.

-- 
                                                                Gilles.

