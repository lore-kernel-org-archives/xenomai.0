Subject: Re: is clock_nanosleep ok?
References: <CAK6DXL01snXqWfUPh3wVTgqLR0V4MWHzJ-PF-JtyOCSZJWC+yQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ec2d99c2-1294-827c-2adc-89a15b18f388@siemens.com>
Date: Mon, 28 Jun 2021 08:33:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAK6DXL01snXqWfUPh3wVTgqLR0V4MWHzJ-PF-JtyOCSZJWC+yQ@mail.gmail.com>
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
To: Marco Barletta <barlettamarco8@gmail.com>, xenomai@xenomai.org

On 23.06.21 12:36, Marco Barletta via Xenomai wrote:
> Hi everyone;
> I need to do some stress-tests and i found some programs ad-hoc that wait
> period with clocknanosleep. In the xenomai doc is written to use a timer or
> a timerfd. So the question is: is ok to use clock_nanosleep? Why isn't it
> listed between methods to wait period?

You can use clock_nanosleep just like other methods. What is best
depends on your application, if there are additional needs that make one
or the other method more favorable from the API point of view.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

