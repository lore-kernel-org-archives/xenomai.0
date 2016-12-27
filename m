References: <CAMcKmiH1se39BmTeYEgqc1GnSQL_UdO3+eeQTR+Mf4dQQma09Q@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f9b76361-9895-4a1f-d0c7-66376754bc72@xenomai.org>
Date: Tue, 27 Dec 2016 20:37:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAMcKmiH1se39BmTeYEgqc1GnSQL_UdO3+eeQTR+Mf4dQQma09Q@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] behavior of cobalt-wrapped fwrite()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Broz <brozgeo@gmail.com>, xenomai@xenomai.org

On 12/27/2016 06:54 PM, George Broz wrote:
> Hello,
> 
> I'm running Xenomai 3.0.2, with Linux 3.18.20. I have an application
> that uses the Cobalt (POSIX) API, using several Xenomai
> threads/tasks (all priority > 0).
> 
> One of these threads makes several calls to fwrite(), each time
> appending a chunk of data to a given open file on the flash file
> system. The fwrite()'s are spread out; in between the calls, other
> threads get a chance to run. Eventually, the file is fclose()'d.
> 
> The resulting file should be around 2MB, but ends up being about
> 200kB (and I'm not sure which 200kB that is). If I sum up the
> returns of each fwrite() call made, then that returns the expected
>  2 MB size (which the resulting file does not reflect).
> 
> Compiled as a Linux application, this use of fwrite() works.
> 
> Running on Xenomai, if I use:
> 
>     __real_fwrite() instead of fwrite()
> 
> then that also works (i.e. the full 2MB gets written).
> 
> I have tried to "fflush" after each fwrite(), and before the fclose(),
> but that made no difference.
> 
> A similar situation is described for Xenomai 2.6.3 in this thread:
> http://xenomai.org/pipermail/xenomai/2015-January/032975.html
> 
> My question is... is this an issue with Cobalt's fwrite()
> implementation,

Does passing --print-buffer-size=2097152 as a command line argument
change/improve the behavior?

 or am I expected to use __real_fwrite() in such
> cases? And then, should I be using __real counterparts
> for fopen, fread, etc. as well? And what is the litmus test
> for using the __real_XXX prefixed function calls?

When a fairly high output rate or volume is expected, __real_* should be
preferred when the caller is a non-RT Xenomai thread (i.e. SCHED_OTHER
or SCHED_WEAK), or whenever such thread is not a Xenomai thread (i.e.
not created by libcobalt's pthread_create() but glibc's).

-- 
Philippe.

