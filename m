Message-ID: <46003635.2020509@domain.hid>
Date: Tue, 20 Mar 2007 20:29:57 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RT-Socket-CAN bus error rate and latencies
References: <46002EE0.9040406@domain.hid> <460031B4.1030906@domain.hid>
In-Reply-To: <460031B4.1030906@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: socketcan-core@domain.hid, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> on the Xenomai mailing list the topic "bus error flooding" popped up
>> again. Various users reported trouble due to high bus error rates and
>> bad impact on latencies. Some discussion is going on on how to avoid
>> such flooding. I have already implemented "on-demand" bus error
>> interrupts. Bus error interrupts are then only enabled when at least one
>> socket is listening on bus errors. But flooding can still occur and we
>> are thinking about a better way of downscaling or temporarily disabling
>> them. Socket-CAN currently restarts the controller after 200 bus errors.
>> My preferred solution for RT-Socket-CAN currently is to stop the CAN
>> controller after a kernel configurable amount of successive bus errors.
>> More clever ideas and comments are welcome?
>>
>> To have some input, I have measured the bus error rate with the PEAK
>> PCAN PCI card on my Icecube MPC5200 eval-board doing rtcansend without
>> cable connected. Here are the results for the various baud-rates:
>>
>>    125 KB/s  1926 BEI/s
>>    250 KB/s  3925 BEI/s
>>    500 KB/s  7856 BEI/s
>>   1000 KB/s 15700 BEI/s
> 
> So bus errors come in at a rate comparable to shortest possible frames
> at maximum speed, right? That's an IRQ load you can live with - if you
> plan to load your CAN bus at 100% anyway. But if you don't...

Yes, it looks like.

>> The latency measured with "latency" from the testsuite reported an
>> increase of the latency with load from 67 to 95us almost independently
>> of the baud-rate. Sending messages with 8 byte payload from MSCAN to
>> SJA1000 on the same node as fast as possible increased the latency up to
>> 103us. This measurement did not include delivery of messages to sockets
>> (actually no socket was listening).
>>
> 
> Some dump of /proc/xenomai/stat would be interesting (system load in
> both cases).

OK, here for bus error flooding at 1MB/s:

bash-2.05b# cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
   0  0      0          9781211    0     00500080   74.0  ROOT
   0  27199  130        264        0     00300182    0.0  display-27197
   0  27200  0          260166     0     00300184    8.1  sampling-27197
   0  0      0          29325916   0     00000000   14.5  IRQ0: SJA1000
   0  0      0          0          0     00000000    0.0  IRQ0: SJA1000
   0  0      0          1000002    0     00000000    0.0  IRQ55: MSCAN
   0  0      0          0          0     00000000    0.0  IRQ56: MSCAN
   0  0      0          9685429    0     00000000    3.0  IRQ256: [timer]

and here for "rtcansend -d 0 -l 1000000 rtcan0 1 2 3 4 5 6 7":

bash-2.05b# cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
   0  0      0          10377571   0     00500080   51.5  ROOT
   0  27199  336        816        0     00300182    0.0  display-27197
   0  27200  0          672738     0     00300184    5.8  sampling-27197
   0  29526  0          291678     0     00300182   23.6  rtcansend-29526
   0  0      0          30863047   0     00000000    9.7  IRQ0: SJA1000
   0  0      0          0          0     00000000    0.0  IRQ0: SJA1000
   0  0      0          1242608    0     00000000    6.5  IRQ55: MSCAN
   0  0      0          0          0     00000000    0.0  IRQ56: MSCAN
   0  0      0          10115159   0     00000000    2.1  IRQ256: [timer]

Wolfgang.


