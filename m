References: <7a4b9236.60185.162b3c8628b.Coremail.yanghaha@whu.edu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <791b65c0-f67d-bc70-5a84-596d74de3b4d@siemens.com>
Date: Wed, 11 Apr 2018 17:24:20 +0200
MIME-Version: 1.0
In-Reply-To: <7a4b9236.60185.162b3c8628b.Coremail.yanghaha@whu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai and I-pipe source code analysis
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5p2o5aOu?= <yanghaha@whu.edu.cn>, xenomai@xenomai.org

On 2018-04-11 10:17, 杨壮 wrote:
> I am trying to measure software integrity in the Xenomai dual-core system to ensure software security. 
> Therefore, I want to have a deep understanding of the Xenomai and I-pipe source code, and then I can insert my code to measure the integrity of the software. 
> However, I found that the functions in the I-pipe patch do not have corresponding comments. 
> This makes it difficult for me to understand the function call flow, and I cannot understand the details of the I-pipe task scheduling. 
> I have tried to use the I-pipe tracer to debug the kernel source but it was not successful. 
> So how do I solve my problem, what good advice do you have?

I suspect your problem starts much earlier: Do you have dual-core
hardware that is ensuring hardware safety? Before that, it's only an
academic exercise to look at the software from a safety point of view.

Jan
-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

