MIME-Version: 1.0
From: Marco Barletta <barlettamarco8@gmail.com>
Date: Wed, 23 Jun 2021 12:36:50 +0200
Message-ID: <CAK6DXL01snXqWfUPh3wVTgqLR0V4MWHzJ-PF-JtyOCSZJWC+yQ@mail.gmail.com>
Subject: is clock_nanosleep ok?
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everyone;
I need to do some stress-tests and i found some programs ad-hoc that wait
period with clocknanosleep. In the xenomai doc is written to use a timer or
a timerfd. So the question is: is ok to use clock_nanosleep? Why isn't it
listed between methods to wait period?
Best regards,
Marco

-- 
Marco Barletta
