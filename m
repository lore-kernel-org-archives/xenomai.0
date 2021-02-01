Subject: Re: Xenomai scheduler
References: <CAFZ-hKhx9FFTP1wdb2OK9oRtML8Aot2kNrkfzw74JPOfam_OKg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <43ef01e1-37b0-f65c-785c-e240017f4974@siemens.com>
Date: Mon, 1 Feb 2021 09:11:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAFZ-hKhx9FFTP1wdb2OK9oRtML8Aot2kNrkfzw74JPOfam_OKg@mail.gmail.com>
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

On 01.02.21 08:47, Leandro Bucci via Xenomai wrote:
> hi, I wanted to know how the Xenomai scheduler works. If I assign three
> tasks to processor CPU 0 and four tasks to processor CPU 1, is it possible
> that the tasks will run simultaneously (one on CPU 0 and one on CPU 1)?
> 

Yes.

Xenomai does no load balancing, i.e. it does not touch the affinity you
assign - or the one Linux picked during startup if you do not assign
anything.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

