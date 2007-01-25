Message-ID: <45B89A61.7000509@domain.hid>
Date: Thu, 25 Jan 2007 12:54:09 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] printf() allowed in xenomai?
References: <45B89438.4000806@domain.hid> <1169725412.5028.33.camel@domain.hid>
In-Reply-To: <1169725412.5028.33.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai Help <xenomai@xenomai.org>

Philippe,

>> I wonder if there exists a document that describes to Dos and Donts when
>> programming real time applications with Xenomai.
> 
> This is a good starting point, discussing about basic issues to keep in
> mind when using something based on a co-kernel technology:
> http://www.xenomai.org/documentation/branches/v2.0.x/pdf/Native-API-Tour.pdf
> http://www.xenomai.org/documentation/branches/v2.0.x/pdf/Life-with-Adeos.pdf

Thanks!

>> For excample is it allowed to used glibc funkctions like printf()?
> 
> Yes, but time-wise, this costs you predictability. You may want to grep
> the mailing list archive about "secondary mode switch" and the like.

Would you please state in one line what "secondary mode switch" means?
Is it the switch from xenomai to linux?

Steven

