From: Harco Kuppens <h.kuppens@cs.ru.nl>
Message-ID: <13c4f7b0-0d88-d98b-3963-6337f3386632@cs.ru.nl>
Date: Tue, 11 Jul 2017 16:54:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] strerror or symerror
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


When looking at some of the test programs coming with xenomai 3  I 
noticed that they use symerror instead of strerror.
e.g. in ./testsuite/gpiotest/gpiotest.c

I saw that within xenomai symerror is defined in 
./lib/boilerplate/ancillaries.c, and is xenomai specific.

Should I use symerror instead of strerror in realtime code?


Best regards,
Harco Kuppens

ps. I was also wondering if there is some reasoning about the names 
cobalt and mercury?


