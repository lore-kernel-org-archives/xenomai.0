Message-ID: <bc5db3f3-2a61-c593-d71d-7029afe1fe16@siemens.com>
Date: Wed, 9 Feb 2022 18:51:33 +0100
MIME-Version: 1.0
Subject: Re: Questions about Xenomai
Content-Language: en-US
References: <CAGjgvr_QGmQiHEXnuhZ4kbA+KsBk+qs78jJ+15Bpb6NbGqq3Lg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAGjgvr_QGmQiHEXnuhZ4kbA+KsBk+qs78jJ+15Bpb6NbGqq3Lg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Yucong Chen <slaoub@gmail.com>, xenomai@xenomai.org

On 09.02.22 04:58, Yucong Chen wrote:
> Hi all,
> I have two questions for you about Xenomai. Could you spare me some time?
> 1. Whether the Xenomai can be used for automotive and safety critical
> systems?

Certifying Linux is a challenge, see e.g. https://elisa.tech/. It's not
impossible, it's often "just" not affordable when it comes to execution
maintenance. Xenomai adds code to the Linux system, and that will not
immediately make such a task simpler.

> 2. What is the future of Xenomai 4 (EVL Project)?
> Looking forward to hearing from you. Thank you in advance.

We cannot predict the future, so we cannot tell you what it will be. But
the goal of the Xenomai project is to enable a smooth transition of
Xenomai 3.x applications to a Xenomai 4.x (EVL-based) line in order to
use the architectural benefits of EVL. That still requires changes,
likely on both sides (less on EVL, though), so this is the more
foreseeable part of the future.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

