Message-ID: <4FCCB885.60802@gmail.com>
Date: Mon, 04 Jun 2012 19:00:45 +0530
From: abhri <abhri.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] question on host tick processing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
I have a doubt regarding host tick propagation. I understand that host 
tick will be relayed when XNHTICK bit is set and there is a domain 
migration to root. In case there is large delay to change domain from 
primary to secondary how is the host tick corrected when relayed next. 
Is there any correction mechanism in nucleus for keeping linux time correct?

Regards,
AB

