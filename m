Subject: Re: What is the highest value returned by rt_timer_read?
References: <CAKP50V4e5Np-wFPzOLPHiVtKhwxnLreg18zTZRYs6-pTTqTN4Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8e2ed529-3c99-3f3b-bb29-430645870df2@siemens.com>
Date: Tue, 28 Jan 2020 10:16:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAKP50V4e5Np-wFPzOLPHiVtKhwxnLreg18zTZRYs6-pTTqTN4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Matheus Leitzke <senseipinto@gmail.com>, xenomai@xenomai.org

On 24.01.20 20:02, Matheus Leitzke via Xenomai wrote:
> Hello,
> 
> As I didn't find it in the API manual, I'm using the list to clear my
> doubts.
> What is the highest value returned by rt_timer_read function on Xenomai 3
> Alchemy skin?

Type-wise, it's a 64-bit value, thus (1 << 64) - 1. But we are reading 
from arch-dependent TSCs that may have a smaller range, specifically 
after converting their values to nanoseconds. About which platform are 
we talking here?

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

