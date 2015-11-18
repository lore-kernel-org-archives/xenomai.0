References: <564B02CC.6060609@basystemes.fr>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <564C49CF.1070605@xenomai.org>
Date: Wed, 18 Nov 2015 10:50:07 +0100
MIME-Version: 1.0
In-Reply-To: <564B02CC.6060609@basystemes.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] multiple failing writes to XDDP socket seem to block
 other I/Os
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@basystemes.fr>, xenomai@xenomai.org, Jean-Baptiste Tredez <jean-baptiste.tredez@basystemes.fr>

On 11/17/2015 11:34 AM, Thierry Bultel wrote:
> Hi,
> 
> With xenomai-2.6.4 on IMX6, I am facing an issue, that for now, and
> unfortunately, I have not been able to
> narrow down to a simple test case, but I am still working on it.
> 
> Considering the following piece of code, where :
> 
> - globalLogFd is a XDDP socket, whose rtp backend is no longer
> listening. This works great when the rtp listener pops the messages.
> - fp points to a classical text file
> 
> --------------
> 
> static int cpt;
> void foo() { cpt++; };
> 
> static int cpt2;
> void foo2() { cpt2++; };
> 
> --------------
> 
>     cpt=0;
>     cpt2=0;
> 
>     for (uint32_t i = 0; i < index; i++ )
>     {
>         fprintf(stdout,"in loop: %d\n", i);
>         char msg[256];
>         sprintf(msg, "%d \n",i);
> 
>         size_t ret = write(globalLogFd,msg,strlen(msg)+1);
>         if (ret != strlen(msg)+1) {
>             foo();
>         }
> 
>         count++;
> 
>         fprintf(fp,"%s",m_buffer[i]);
>         foo2();
> 
>     }
> 
>     fflush(fp);
>     fclose(fp);
> 
> The seen effect is that when the XDDP buffer is full, the I/O do not
> work anymore after some number of iterations. The cpt and cpt2 counters

fprintf() relays output data to a low priority thread using lockless
buffers not to delay the real-time caller.

Since the caller has higher priority than the thread handling the stdio
stream, and your code spins indefinitely in that loop without ever
blocking, receiving -ENOMEM continuously:

- how is the relay thread supposed to be able to run for handling the
output?

- how is the non-rt XDDP receiver supposed to consume the data, so that
the -ENOMEM condition would stop on the send side?

Any code that keeps sending requests without acting upon a failure code
it receives doing so, is just asking for trouble.

-- 
Philippe.

