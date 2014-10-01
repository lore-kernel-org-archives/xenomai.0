Message-ID: <542BB9E7.7050008@xenomai.org>
Date: Wed, 01 Oct 2014 10:23:03 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CABaOOZ1C-Yo+SPfbxk35kYavnugGK0yZQ3nYivpritw6wtxO1A@mail.gmail.com>
In-Reply-To: <CABaOOZ1C-Yo+SPfbxk35kYavnugGK0yZQ3nYivpritw6wtxO1A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Can not compile mertcury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stratiyenko Roman <picoworm@gmail.com>, xenomai@xenomai.org

On 10/01/2014 09:35 AM, Stratiyenko Roman wrote:
> Hello,
> 
> Today I downloaded latest xenomai 3 from git.
> I want to try mercury version
> I did ./configure --with-core=mercury
> after make, I have error compiling testsuite
> 
> ../../lib/copperplate/.libs/libcopperplate.so: undefined reference to
> `timer_create'
> ../../lib/copperplate/.libs/libcopperplate.so: undefined reference to
> `timer_delete'
> ../../lib/copperplate/.libs/libcopperplate.so: undefined reference to
> `timer_settime'
> collect2: error: ld returned 1 exit status
> 
> What am I doing wrong?
> 

Nothing, a dependency on librt seems to be unresolved in your case.
Please pull the updates from the -next branch and try again. Feedback
welcome.

Thanks,

-- 
Philippe.

