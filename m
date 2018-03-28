Message-ID: <1522249232.2732.16.camel@sprinte.eu>
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Wed, 28 Mar 2018 17:00:32 +0200
In-Reply-To: <4daad8ee-cdbd-b67b-bc71-ce141e4a60dc@xenomai.org>
References: <1522245644.2732.13.camel@sprinte.eu>
 <4daad8ee-cdbd-b67b-bc71-ce141e4a60dc@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Canonical way to differentiate between NPTL / Cobalt
 threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

Le mercredi 28 mars 2018 à 16:16 +0200, Philippe Gerum a écrit :
> 
> cobalt_thread_pid(pthread_t) from the internal support library would
> do
> the job. A successful call would denote a cobalt thread, -ESRCH would
> denote a regular (or invalid) pthread.

Seems to work perfectly, thanks.

Regards,

Julien

