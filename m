MIME-Version: 1.0
Sender: bodgesoc@gmail.com
In-Reply-To: <52DAE756.3070606@xenomai.org>
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <CAN1+YZWOjxf=s+6LH3Xymzx_mwWa6XmO_Xt7SHF589RzJCANBA@mail.gmail.com>
 <52D8609C.5050903@xenomai.org>
 <CAN1+YZW+nJgMb0hLy2JWZW6JrxA+mZzA+-oN-gjQgeGTcoe0jg@mail.gmail.com>
 <CAN1+YZUY_3FExF=qrUtMQDQxTqossnQsPCy6zfPjfqp8PitZCg@mail.gmail.com>
 <52D9984F.9080203@xenomai.org>
 <CAN1+YZWnLC=MLxWqYd9xH1URimWnOdEhU4mwZ0S3QFdpghUaGQ@mail.gmail.com>
 <52DAE756.3070606@xenomai.org>
From: Andy Pugh <andy@bodgesoc.org>
Date: Sat, 18 Jan 2014 14:31:02 -0800
Message-ID: <CAN1+YZWmjvsu7My92EBktFhWYhheRJvdYrEq=r3+Ravp_Wzoyw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Fwd: Kernel Compilation Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

On 18 January 2014 12:43, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:

> It is an imx6, right? Could you try ton run the X server without
> acceleration (using the fbdev driver)?

That does look a lot more promising:

RTT|  00:00:43  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      6.404|     13.219|     42.202|       0|     0|      1.709|     44.921
RTD|      3.856|     14.416|     46.916|       0|     0|      1.709|     46.916
RTD|      3.765|     15.383|     36.954|       0|     0|      1.709|     46.916
RTD|      2.939|     15.292|     40.489|       0|     0|      1.709|     46.916
RTD|      2.886|     15.669|     75.785|       0|     0|      1.709|     75.785
RTD|      3.679|     15.752|     42.689|       0|     0|      1.709|     75.785
RTD|      4.585|     17.161|     47.861|       0|     0|      1.709|     75.785
RTD|      4.590|     16.749|     46.838|       0|     0|      1.709|     75.785
RTD|      3.343|     14.154|     28.101|       0|     0|      1.709|     75.785
RTD|      3.323|     16.641|     48.358|       0|     0|      1.709|     75.785

The 75uS was the point where I opened a web browser. Running glxgears
seemed to have no effect at all

-- 
atp

