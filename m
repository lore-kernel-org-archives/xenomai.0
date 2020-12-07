Subject: Re: Xenomai scheduler
References: <CAFZ-hKjNB5Le2qvXd609j+O2AxrMehohchqF3Qtr_pr-ULdQSA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8cdb390e-9a76-fc94-d052-66fa921dd791@siemens.com>
Date: Mon, 7 Dec 2020 07:55:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAFZ-hKjNB5Le2qvXd609j+O2AxrMehohchqF3Qtr_pr-ULdQSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leandro Bucci <guestleandro11@gmail.com>, xenomai@xenomai.org

On 05.12.20 09:22, Leandro Bucci via Xenomai wrote:
> hi, i have a doubt about the Xenomai scheduler.  When I create multiple
> tasks, are they assigned to the various available system CPUs?  if I have
> two tasks T1 and T2, where T1 has high priority and T2 low priority, and my
> system has 4 CPUs, does Xenomai assign T1 and T2 to two different
> processors (to optimize) or does it assign them to the same processor?
> 

Xenomai does not implement any kind of load-balancing algorithm. It
simply takes the CPU the Linux part of the thread was running on during
creation. It furthermore accepts any explicit affinity assignments
during runtime. So it's up to you to design the optimal RT thread
placement for your system.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

