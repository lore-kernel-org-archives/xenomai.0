Message-ID: <c3d8d36d26d2a055aa2cd202a06fb0d40b033dce.camel@sprinte.eu>
Subject: Re: "cheap", RT-safe way of detecting if a thread is Xenomai or Linux
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Mon, 14 Jan 2019 09:00:26 +0100
In-Reply-To: <AM0PR07MB5572ECC01EEA3054C3B02A59B5870@AM0PR07MB5572.eurprd07.prod.outlook.com>
References: <AM0PR07MB5572ECC01EEA3054C3B02A59B5870@AM0PR07MB5572.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Le dimanche 13 janvier 2019 à 02:33 +0000, Giulio Moro via Xenomai a
écrit :
> Hi all,
> is there a "cheap", RT-safe call that can be made in order to find
> out if the current thread is a Xenomai thread or a Linux thread?
> Also, to detect whether the Xenomai thread is in primary or secondary
> mode?

quoting Philippe, who i asked a similar question some time ago :

« cobalt_thread_pid(pthread_t) from the internal support library would
do the job. A successful call would denote a cobalt thread, -ESRCH
would denote a regular (or invalid) pthread. »

This works perfectly.

Julien


