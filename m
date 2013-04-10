Message-ID: <5165C158.7060005@gmail.com>
Date: Wed, 10 Apr 2013 21:45:28 +0200
From: Marco Guerri <gmarco.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Kernel space task VS User space task latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everyone,

I was wondering if there is anyone who can help me clarify some very 
basic doubts I have regarding Xenomai internals.
I am working with Xenomai 2.6.2.1 on a 2.6.31 kernel on an i.MX35 
processor (thus, ARM arch).

Using the latency test program, I get the following results for User 
space and Kernel space tasks.

*** IDLE ***
User space --> Mean: ~7us
Kernel space --> Mean: ~4us

*** HEAVY LOAD (dohell) ***
User space --> Mean: ~34us
Kernel space --> Mean: ~18us

Could you give me some hints on how to explain this great difference, 
expecially with the system under load?
What are the factors that could worsen the latency in IDLE conditions?
What are the factors that can explain a value of latency doubled in case 
of a system under load?

Thank you a lot for any suggestion.
Regards,

Marco


