MIME-Version: 1.0
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Sat, 5 Dec 2020 09:22:50 +0100
Message-ID: <CAFZ-hKjNB5Le2qvXd609j+O2AxrMehohchqF3Qtr_pr-ULdQSA@mail.gmail.com>
Subject: Xenomai scheduler
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

hi, i have a doubt about the Xenomai scheduler.  When I create multiple
tasks, are they assigned to the various available system CPUs?  if I have
two tasks T1 and T2, where T1 has high priority and T2 low priority, and my
system has 4 CPUs, does Xenomai assign T1 and T2 to two different
processors (to optimize) or does it assign them to the same processor?
