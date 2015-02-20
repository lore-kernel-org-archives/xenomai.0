MIME-Version: 1.0
In-Reply-To: <20150217181932.GK30245@csclub.uwaterloo.ca>
References: <CALe7ZU0Y4hb0d7ANK9gitLLaQnGFiH8LpH3ZaTQ5MHLCYjAf=w@mail.gmail.com>
 <20150216092513.GA1914@hermes.click-hack.org>
 <20150217173314.GI30245@csclub.uwaterloo.ca>
 <20150217181133.GB17681@hermes.click-hack.org>
 <20150217181932.GK30245@csclub.uwaterloo.ca>
Date: Fri, 20 Feb 2015 18:16:12 +0530
Message-ID: <CALe7ZU2NqcgXM+_F5qr0Jd-Miwdv_RGuYU+Cvrw3kTwk=k0_BQ@mail.gmail.com>
From: JAY KOTHARI <jaikothari10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] rtdm_irq_request not registering irq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

     I am using devm_request_irq() with rtdm_irq_request , rtdm driver
is loading fine but when I call it with application,application gets
hanged on interrupt. The same driver when I register with
devm_request_irq() its working okay. What might occurred this hang?

    As per suggestion I register a dummy handler of devm_request_irq()
which return IRQ_HANDLED while rtdm_irq_request does the main job for
my driver.

Jay Kothari

