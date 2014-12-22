From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 22 Dec 2014 15:22:55 -0500
Message-ID: <20141222202254.GN24110@csclub.uwaterloo.ca>
References: <CAFgu5KXBDRLxt4q3PUw9he+4Z97RV0=Q96Y+or7FzEwT3CVZRA@mail.gmail.com>
 <20141220153337.GD24110@csclub.uwaterloo.ca>
 <20141220160408.GB3961@daedalus>
 <20141220162139.GF24110@csclub.uwaterloo.ca>
 <20141220162937.GA12315@daedalus.click-hack.org>
 <CAFgu5KVAKhXC+Tzds-b2P5o6+u+xBwZz_tL5-j2GL6sjbkme4g@mail.gmail.com>
 <CAFgu5KUG9N-13DwqwW9ryp0J3_9qvmB=A4A6x=2qk29BHSEzHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgu5KUG9N-13DwqwW9ryp0J3_9qvmB=A4A6x=2qk29BHSEzHQ@mail.gmail.com>
Subject: Re: [Xenomai] Kernel Configuration Woes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Justin Hart <justin.hart@mech.ubc.ca>
Cc: xenomai@xenomai.org

On Mon, Dec 22, 2014 at 12:05:35PM -0800, Justin Hart wrote:
> Oh, Lennart.  Commodity hardware.  Core i7, 32G RAM, Ubuntu 14.04, kernel
> as described above, Linux 3.14.17 w/ Xenomai 2.6.4 with the packaged Adeos
> patch.  The only thing interesting about the configuration that I thought
> might be contributing to issues is running the CUDA driver.  I stumbled
> onto the hypothesis that something was wrong with the kernel because I was
> having rendering issues.  Backing out CUDA appeared to resolve the issues,
> but I think that it's my software doing something *really* boneheaded.  I
> have a small GUI that I wrote that displays the current pose of the arm.  I
> think that I'm refreshing a set of gtk_entries with gtk_entry_set_text
> every time the arm's position is updated.  I *should* be doing this in a
> GTK worker that just updates it every time it goes through gtk_main_loop.
> I think that what I'm doing is simply giving too many events to the
> x-server.  I first noticed this because there was some latency in the arm's
> responsiveness.
> 
> Altering it to test this should be easy enough, though.

Well as was mentioned recently on the list, if you use the nvidia kernel
modules, then you really can not expect xenomai/ipipe to work properly,
because you can't fix what the binary blob from nvidia does, and it
could easily mess up interrupt handling and make the realtime stop
being realtime.

-- 
Len Sorensen

