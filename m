Message-ID: <540CA40E.9030308@xenomai.org>
Date: Sun, 07 Sep 2014 20:29:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5408A860.3020002@gatech.edu> <5408ADA2.1000401@xenomai.org>
 <5408C529.4080202@gatech.edu> <5408C74B.2010706@xenomai.org>
 <540C8EF5.4090104@xenomai.org> <540C9126.1060403@gatech.edu>
In-Reply-To: <540C9126.1060403@gatech.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Error compiling on P4 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>, xenomai@xenomai.org

On 09/07/2014 07:08 PM, Yogi A. Patel wrote:
> On 09/07/2014 12:59 PM, Gilles Chanteperdrix wrote:
>> On 09/04/2014 10:10 PM, Gilles Chanteperdrix wrote:
>>> On 09/04/2014 10:01 PM, Yogi A. Patel wrote:
>>>> Using
>>>>
>>>> Xenomai 2.6.3 and ipipe-core-3.8.13-x86-4.patch
>>>>
>>> This combination works for me.
>>>
>>> This was a (failed) attempt to make you realize that you should give us
>>> all the information allowing to reproduce your issue, otherwise there is
>>> not much we can do. The missing information here is the kernel
>>> configuration.
> Lesson learned.

Next time, please send the .config as an attachment, it makes it easier
for us to manipulate, and avoid sending it to all the subscribers of the
list who probably do not care.

So, I followed the following procedure:

tar -xf /path/to/linux-3.8.13.tar.xz
tar -xf /path/to/xenomai-2.6.3.tar.bz2
cd linux-3.8.13/
../xenomai-2.6.3/scripts/prepare-kernel.sh --linux=. --arch=x86
cp /path/to/your/.config .config
make ARCH=x86 oldconfig

At this point oldconfig asks me a question, which makes me doubt that
the config you sent me was really used to compile a kernel.

Then I run:
make -j 12 ARCH=x86
which ends with an issue in analogy (undefined reference to
a4l_proc_root), I will have a look into this.

Then
make -j 12 ARCH=x86 modules
Which runs correctly.

Anyway, except for the fact that it takes ages to compile because it
enables way too much stuff, including CONFIG_INTEL_IDLE which should be
disabled (as documented), your config seems to compile fine here.

So, are you sure you sent me the .config with which you had a problem?
If yes, how do you compile the kernel?


-- 
                                                                Gilles.

