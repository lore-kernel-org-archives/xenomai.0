Message-ID: <50B73EA7.3070501@thrane.com>
Date: Thu, 29 Nov 2012 11:53:27 +0100
From: Jesper Christensen <jbc@thrane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] mutex and timers
Reply-To: jesper.christensen@cobham.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

I was wondering if (and i have a feeling i already know the answer) it
is a no-go to call rtdm_mutex_lock from a rtdm timer handler? I've just
discovered that is what we do, and i have a feeling it is causing
trouble (most of the time it seems to work however).
-- 
/Jesper B. Christensen
Development Engineer
T +45 39 55 88 02
E jesper.christensen@cobham.com
Thrane & Thrane A/S - Lundtoftegaardsvej 93D
DK-2800 Kgs. Lyngby, Denmark - www.thrane.com

