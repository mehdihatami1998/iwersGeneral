import os
from PIL import Image
from torch.utils.data import Dataset


class FloodDataset(Dataset):
    def __init__(self, rootdir='dataset', split='train', tranform=None):
        super(FloodDataset, self).__init__() 

        self.rootdir = rootdir
        self.split = split
        self.transform = tranform

        self.images_base = os.path.join(self.rootdir, self.split) 
        self.items_list, self.classes = self.get_images_list()
    
    def get_images_list(self):
        
        items_list = list()
        classes = list()
        # counter = 0
        for idx, (root, dirs, files) in enumerate(os.walk(self.images_base, topdown=False)):
            if idx == 0:
                classes = dirs

            for file in files:
                if file.endswith(".jpg"):
                    items_list.append({
                        "image": os.path.join(root, file),
                        "label": idx - 1,
                        "class_name": classes[idx - 1]
                    })
            # counter += 1
        return items_list, classes
    
    def __getitem__(self, index):
        image_path = self.items_list[index]['image']
        label = self.items_list[index]['label']
        class_name = self.items_list[index]['class_name']
        
        image = Image.open(image_path).convert('RGB')

        if self.transform:
            image = self.transform(image)

        return image, label, class_name

    def __len__(self):
        return len(self.items_list)
  

if __name__ == '__main__':

    dataset = FloodDataset(split='val')

    dataiter = iter(dataset)
    image, label, class_name = next(dataiter)
    print(image.size)
    print(label)
    print(class_name)