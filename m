Subject: Re: High latency when over stress
References: <SN6PR08MB5661F9CC518F4FDBA2B20066939B9@SN6PR08MB5661.namprd08.prod.outlook.com>
From: song <chensong@tj.kylinos.cn>
Message-ID: <e1bd5679-db02-0657-eab7-fbdd2a68f294@tj.kylinos.cn>+0D7DD2791DB31AF7
Date: Mon, 1 Mar 2021 10:13:02 +0800
MIME-Version: 1.0
In-Reply-To: <SN6PR08MB5661F9CC518F4FDBA2B20066939B9@SN6PR08MB5661.namprd08.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gabriel Dinse <gabriel_dinse@hotmail.com>, xenomai@xenomai.org

trace-cmd start -e all; your periodic task
trace-cmd stop
trace-cmd extract
trace-cmd report -l

catch ftrace log to see what is going on in the system.

Song

On 2021/3/1 上午6:26, Gabriel Dinse via Xenomai wrote:
> Hello,
> I'm doing a comparison of interrupt handling on Xenomai using a 
> raspberry pi 3-b in 2 situations:
> 1- No stress
> 2- Running stress-ng on terminal: $ nice -19 stress-ng -c 4 --metrics 
> --timeout 120s&
> 
> What I do is to create a periodic task (priority 50) that runs every 
> 500us activating gpio22 for 250us and save the activating time. Another 
> task, with priority 99 is meant to catch the interrupts in a while loop 
> and save the time as well for computing the time differences later. This 
> is done 100000 times and in the end I do some verifications.
> 
> On situation 1 (no stress) I get:
> Min: 11823ns
> Max: 17761ns
> Standard deviation: 258.96ns
> Mean: 13103.17ns
> 
> On situation 2 (with cpu stress)  I get:
> Min: 12239ns
> Max: 721302ns
> Standard deviation: 32976.01ns
> Mean: 29112.24ns
> 
> I would not say the higher mean is actually a problem (could be), but 
> the standard deviation is much higher and I don't think this is the 
> desired result for Xenomai.
> Is the first result fine?
> What could be causing this?
> Any addition information just ask me.
> 
> Thank you,
> Gabriel Dinse
> 
> 

