From: Thierry Bultel <thierry.bultel@basystemes.fr>
Message-ID: <564B02CC.6060609@basystemes.fr>
Date: Tue, 17 Nov 2015 11:34:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] multiple failing writes to XDDP socket seem to block
	other I/Os
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Jean-Baptiste Tredez <jean-baptiste.tredez@basystemes.fr>

Hi,

With xenomai-2.6.4 on IMX6, I am facing an issue, that for now, and 
unfortunately, I have not been able to
narrow down to a simple test case, but I am still working on it.

Considering the following piece of code, where :

- globalLogFd is a XDDP socket, whose rtp backend is no longer 
listening. This works great when the rtp listener pops the messages.
- fp points to a classical text file

--------------

static int cpt;
void foo() { cpt++; };

static int cpt2;
void foo2() { cpt2++; };

--------------

     cpt=0;
     cpt2=0;

     for (uint32_t i = 0; i < index; i++ )
     {
         fprintf(stdout,"in loop: %d\n", i);
         char msg[256];
         sprintf(msg, "%d \n",i);

         size_t ret = write(globalLogFd,msg,strlen(msg)+1);
         if (ret != strlen(msg)+1) {
             foo();
         }

         count++;

         fprintf(fp,"%s",m_buffer[i]);
         foo2();

     }

     fflush(fp);
     fclose(fp);

The seen effect is that when the XDDP buffer is full, the I/O do not 
work anymore after some number of iterations. The cpt and cpt2 counters 
have been correctly incremented 'index' times, but neither the fprintf 
to stdout, nor the fprintf to fp do anything.
The context is not an RT thread. I am aware that sharing the globalLogFd
between RT and non RT threads is likely not a good idea.

The interesting thing to notice is that subsequent calls to the loop
make the thing happen again -> the fprintf work for a number of times
and then stop (about 300 times on a total of 1000).

Commenting out the write to globalLogFd lets the fprintf work for all 
iterations, as expected.

Best regards
Thierry

