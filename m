MIME-Version: 1.0
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Wed, 3 Mar 2021 15:45:35 +0100
Message-ID: <CAFZ-hKgcskeJnaBe6+_qAZQ6TQQhyVnShHXwaE==ScSVJLtU_w@mail.gmail.com>
Subject: Execution time
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi, I noticed a very strange but also interesting fact. When a certain
periodic task is executed, if the period is small (for example 0.5ms) I
have that the execution times are more or less constant (about 5 micro
seconds). If, on the other hand, the period of the same task is larger (for
example 10ms), the execution times are less predictable and range from 5
micro seconds to 15 micro seconds.

How is this possible? I am using a raspberry Pi3 and the task is running on
a core dedicated to xenomai.

<https://www.avast.com/sig-email?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail>
Mail
priva di virus. www.avast.com
<https://www.avast.com/sig-email?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail>
<#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2>
