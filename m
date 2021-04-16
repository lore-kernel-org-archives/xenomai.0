Subject: Re: [PATCH V2 3/3] testsuite/latmus: introduce latmus benchmark
References: <20210416053133.23412-1-hongzhan.chen@intel.com>
 <20210416053133.23412-4-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <17adb9ac-7510-f1f6-9805-67ef8353b536@siemens.com>
Date: Fri, 16 Apr 2021 14:05:14 +0200
MIME-Version: 1.0
In-Reply-To: <20210416053133.23412-4-hongzhan.chen@intel.com>
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
To: hongzha1 <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 16.04.21 07:31, hongzha1 via Xenomai wrote:
> Measure response time to GPIO events sent by a remote Zephyr-based
> latency monitor (latmon). This monitor collects then sends the latency
> data over a network connection to the latmus front-end which displays
> the results received:
> 
> [Linux device under test running latmus]  <--+
>                                              |
>         ^                 | (GPIO ack)       |
>         |                 |                  |  TCP/IP network connection
>         |                 |                  |  (control & data samples)
>         | (GPIO pulse)    v                  |
>                                              |
> [Zephyr-based device running latmon]      <--+
> 
> The generic latency monitor code running the measurement loop is
> available from the zephyr/ directory. This support comes with a Zephyr
> device tree patch for enabling this monitor on NXP's FRDM-K64F
> development board.

Where is all this?

BTW, would some cheap Arduino board and sketch be an alternative? They
could expose the recorded data via USB to the host (even the DUT).
Provided they have enough free RAM to compensate the transfer delay.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

