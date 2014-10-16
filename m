Message-ID: <1413460213.12609.YahooMailNeo@web121502.mail.ne1.yahoo.com>
Date: Thu, 16 Oct 2014 04:50:13 -0700
From: Arsalan Shahid <arsalan_shahid116@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai] undefined reference of rt_timer_read()
Reply-To: Arsalan Shahid <arsalan_shahid116@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi 

I pray that this message finds you in the Best of Health & Happiness


I am using NATIVE skin of Xenomai along with OpenMP. Xenomai works perfectly fine with NATIVE skin when we use it along OpenMP. But In my codes when ever I tried to access any Function of Native skin I get an error in compilation. I used rt_timer_read() as shown below.

RTIME now;
now = rt_timer_read();

code.c:(.text+0x33): undefined reference to `rt_timer_read'
code.c:(.text+0x49): undefined reference to `rt_timer_ticks2ns'

Same is the case when I call used rt_printf. Another thing which comes while compiling Xenomai application occurs when I give command line option (-lrtdk). Without this code is compiled but with this it gives error.

Kindly guide me.

Thanks & Regards
Arsalan Shahid 
