MIME-Version: 1.0
Date: Fri, 20 Feb 2015 14:31:56 +0530
Message-ID: <CALe7ZU2FV4WTd-ACRYwLyz6hC1-7NG3rCqcL3Ke5t=k74DGmeA@mail.gmail.com>
From: JAY KOTHARI <jaikothari10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] rtdm_event_wait not working as expected
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hello,
      I am using rtdm_event_wait() which returns 0 even I havn't used
rtdm_event_signal(). My rtdm driver is not going into blocking state.
I am using arm platform. On x86 platform this api worked
perfectly.What might be I missing?

Thank you

Jay Kothari

