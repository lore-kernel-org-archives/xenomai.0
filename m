MIME-Version: 1.0
Sender: bodgesoc@gmail.com
In-Reply-To: <52D9984F.9080203@xenomai.org>
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <CAN1+YZWOjxf=s+6LH3Xymzx_mwWa6XmO_Xt7SHF589RzJCANBA@mail.gmail.com>
 <52D8609C.5050903@xenomai.org>
 <CAN1+YZW+nJgMb0hLy2JWZW6JrxA+mZzA+-oN-gjQgeGTcoe0jg@mail.gmail.com>
 <CAN1+YZUY_3FExF=qrUtMQDQxTqossnQsPCy6zfPjfqp8PitZCg@mail.gmail.com>
 <52D9984F.9080203@xenomai.org>
From: Andy Pugh <andy@bodgesoc.org>
Date: Sat, 18 Jan 2014 11:49:45 -0800
Message-ID: <CAN1+YZWnLC=MLxWqYd9xH1URimWnOdEhU4mwZ0S3QFdpghUaGQ@mail.gmail.com>
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
Cc: xenomai <xenomai@xenomai.org>

On 17 January 2014 12:53, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:

> It looks ok, you should run xeno-test instead of xeno-regression-test,
> and see if you get acceptable latencies.


Unfortunately not. Opening a web browser pushed latency up to > 1000 uS.


RTD|      8.313|     15.106|     28.199|       0|     0|      4.249|     31.477
RTD|      7.989|     15.181|     29.255|       0|     0|      4.249|     31.477
RTD|      3.722|     14.727|     32.093|       0|     0|      3.722|     32.093
RTD|      4.484|     16.202|    401.648|       0|     0|      3.722|    401.648
RTD|      8.078|     19.323|     57.929|       0|     0|      3.722|    401.648
RTD|      4.191|     16.343|     31.941|       0|     0|      3.722|    401.648
RTD|      7.169|     16.787|     41.795|       0|     0|      3.722|    401.648
RTD|      8.707|     16.669|     39.275|       0|     0|      3.722|    401.648
RTD|      4.636|     17.320|     37.303|       0|     0|      3.722|    401.648
RTD|      8.406|     17.563|     59.111|       0|     0|      3.722|    401.648
RTD|      9.330|     17.797|     33.752|       0|     0|      3.722|    401.648
RTD|      8.282|     18.666|     46.007|       0|     0|      3.722|    401.648
RTD|      3.891|     17.876|     37.727|       0|     0|      3.722|    401.648
RTD|      9.146|     18.017|     46.752|       0|     0|      3.722|    401.648
RTD|      8.560|     19.330|     48.441|       0|     0|      3.722|    401.648
RTD|      3.909|     19.694|    314.227|       0|     0|      3.722|    401.648
RTD|      4.891|     20.189|    220.487|       0|     0|      3.722|    401.648
RTD|      4.255|     22.742|    755.479|       0|     0|      3.722|    755.479
RTD|      3.661|     16.012|     30.378|       0|     0|      3.661|    755.479
RTD|      3.828|     21.252|    646.782|       0|     0|      3.661|    755.479
RTD|      3.800|     16.906|     34.547|       0|     0|      3.661|    755.479
RTD|      6.424|     16.856|     33.719|       0|     0|      3.661|    755.479
RTD|      8.373|     23.015|    662.608|       0|     0|      3.661|    755.479
RTD|      3.654|     17.161|     33.628|       0|     0|      3.654|    755.479
RTD|      4.378|     20.598|   1260.792|       1|     0|      3.654|   1260.792


-- 
atp

