Date: Fri, 4 Nov 2016 10:48:06 -0400
Message-ID: <20161104144806.GP1465@csclub.uwaterloo.ca>
References: <CAPdz0-x=sQMY-0DKYQX+PXjXM0br6eGm=Kyo_CrBPtwJndGfnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPdz0-x=sQMY-0DKYQX+PXjXM0br6eGm=Kyo_CrBPtwJndGfnA@mail.gmail.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] Writing into files without mode switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Florian G." <florian.r.groeger@gmail.com>
Cc: xenomai@xenomai.org

On Fri, Nov 04, 2016 at 12:55:01AM +0100, Florian G. wrote:
> I'm using Xenomai 2.6.5 on a 3.8.13 kernel on an ARM 32-bit(BeagleBone
> Black).
> Right now we need a way to write into files without getting a mode switch.
> I tried to use the rtdk.h header, but it won't work.
> rt_printf works perfectly fine, but I am not able to write something in a
> file. The code is compiled with gcc and the xenomai flags of the native
> skin.
> 
> What do I do wrong?
> Do I have to set an additional flag? Open the file in a different way?
> Is there another way to achieve writing into a file without mode switch
> and without writing my own RTDM?

Well filesystems are managed by linux, disk response time is not
predictable, so really, I don't see how you could do file access from
realtime.

I could be wrong, but I just don't see it.

-- 
Len Sorensen

